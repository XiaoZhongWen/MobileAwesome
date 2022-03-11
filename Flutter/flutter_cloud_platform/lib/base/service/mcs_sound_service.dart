import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_cloud_platform/base/extension/string_extension.dart';

class MCSSoundService {
  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  final FlutterSoundHelper _soundHelper = FlutterSoundHelper();
  final FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();
  ValueChanged<int>? onVolume;

  static final MCSSoundService singleton = MCSSoundService._();
  final String _audioCacheDirName = 'audio';
  final int _sample = 8000;
  late String _rootDirPath;
  late String _tmpDir;
  String? _key;

  MCSSoundService._();

  void startService() async {
    await _soundRecorder.openAudioSession(
      focus: AudioFocus.requestFocusTransient,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker
    );
    await _soundPlayer.openAudioSession(
      focus: AudioFocus.requestFocusTransient,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker
    );
    _soundRecorder.setSubscriptionDuration(const Duration(milliseconds: 100));
    _soundRecorder.dispositionStream()?.listen((e) {
      if (onVolume != null) {
        int v = e.decibels! ~/ 1.2;
        onVolume!(v);
      }
    });
    Directory dir = await getApplicationDocumentsDirectory();
    _rootDirPath = join(dir.path, _audioCacheDirName);
    Directory tmp = await getTemporaryDirectory();
    _tmpDir = tmp.path;
    Directory audioDir = Directory(_rootDirPath);
    bool isExist = await audioDir.exists();
    if (!isExist) {
      await audioDir.create();
    }
  }

  bool startRecorder() {
    if (_soundRecorder.isRecording) {
      return false;
    }
    String path = join(_rootDirPath, const Uuid().v1()) + '.pcm';
    _soundRecorder.startRecorder(
      codec: Codec.pcm16,
      toFile: path,
      audioSource: AudioSource.microphone,
      sampleRate: _sample
    );
    return true;
  }

  Future<String?> stopRecorder({bool cancel = false}) async {
    onVolume = null;
    String? url = await _soundRecorder.stopRecorder();
    String? wav = url?.replaceFirst('.pcm', '.wav');
    String? amr = url?.replaceFirst('.pcm', '.amr');
    if (url != null) {
      File pcm = File(url);
      bool pcmIsExist = await pcm.exists();
      if (cancel) {
        if (pcmIsExist) {
          pcm.delete();
        }
        return null;
      }
      await _soundHelper.pcmToWave(inputFile: url, outputFile: wav!, sampleRate: _sample);
      await _soundHelper.convertFile(wav, Codec.pcm16, amr!, Codec.amrNB);
      pcm.delete();
      File pcmWav = File(wav);
      bool pcmWavIsExist = await pcmWav.exists();
      if (pcmWavIsExist) {
        pcmWav.delete();
      }
    }
    return amr;
  }

  Future<int> getDuration(String path) async {
    Duration? duration = await _soundHelper.duration(path);
    int sec = duration?.inSeconds ?? 0;
    if (sec == 0) {
      File amr = File(path);
      bool exist = await amr.exists();
      if (exist) {
        amr.delete();
      }
    }
    return sec;
  }

  Future<void> startPlay({required String key, String? fileName, String? url, void Function()? whenFinished}) async {
    if ((fileName == null || fileName.isEmpty) &&
        (url == null || url.isEmpty)) {
      return;
    }
    if (_soundPlayer.isPlaying) {
      stopPlay();
    }
    _key = key;
    bool result = await playWithPath(fileName, whenFinished: whenFinished);
    if (!result) {
      playWithUrl(url, whenFinished: whenFinished);
    }
  }

  String? stopPlay() {
    _soundPlayer.stopPlayer();
    return _key;
  }

  Future<bool> playWithPath(String? fileName, {void Function()? whenFinished}) async {
    if (fileName == null || fileName.isEmpty) {
      return false;
    }
    String path = join(_rootDirPath, fileName);
    File amr = File(path);
    if (amr.existsSync()) {
      String wav = join(_tmpDir, fileName.replaceFirst('.amr', '.wav'));
      File pcm = File(wav);
      bool result = true;
      if (!pcm.existsSync()) {
        result = await _soundHelper.convertFile(path, Codec.amrNB, wav, Codec.pcm16);
      }
      if (result) {
        await _soundPlayer.startPlayer(
            fromURI: wav,
            codec: Codec.pcm16WAV,
            whenFinished: () {
              _key = null;
              if (whenFinished != null) {
                whenFinished();
              }
            }
        );
      }
      return result;
    } else {
      return false;
    }
  }

  void playWithUrl(String? url, {void Function()? whenFinished}) async {
    _soundPlayer.startPlayer(
        fromURI: url,
        codec: Codec.amrNB,
        whenFinished: () {
          _key = null;
          if (whenFinished != null) {
            whenFinished();
          }
        }
    );
  }

  bool isPlaying({String? key}) {
    if (key == null) {
      return _soundPlayer.isPlaying;
    }
    return _soundPlayer.isPlaying && _key == key;
  }

  String currentKey() {
    return _key ?? '';
  }

  void modifyFileName(String prev, String next) {
    File file = File(join(_rootDirPath, prev));
    if (file.existsSync()) {
      file.rename(join(_rootDirPath, next));
    }
  }
}