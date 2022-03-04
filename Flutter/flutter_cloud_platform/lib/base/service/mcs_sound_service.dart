import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class MCSSoundService {
  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  final FlutterSoundHelper _soundHelper = FlutterSoundHelper();

  static final MCSSoundService singleton = MCSSoundService._();
  final String _audioCacheDirName = 'audio';
  final int _sample = 8000;
  late String _rootDirPath;

  MCSSoundService._();

  void startService() async {
    await _soundRecorder.openAudioSession(
      focus: AudioFocus.requestFocusTransient,
      category: SessionCategory.playAndRecord,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker
    );
    Directory dir = await getApplicationDocumentsDirectory();
    _rootDirPath = join(dir.path, _audioCacheDirName);
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
}