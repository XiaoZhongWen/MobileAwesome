import 'dart:io';

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

class MCSSoundService {
  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  final FlutterFFprobe _fFprobe = FlutterFFprobe();

  static final MCSSoundService singleton = MCSSoundService._();
  final String audioCacheDirName = 'audio';
  late String _rootDirPath;

  MCSSoundService._();

  void startService() async {
    await _soundRecorder.openRecorder();
    Directory dir = await getApplicationDocumentsDirectory();
    _rootDirPath = join(dir.path, audioCacheDirName);
    Directory audioDir = Directory(_rootDirPath);
    bool isExist = await audioDir.exists();
    if (!isExist) {
      await audioDir.create();
    }
    _soundRecorder.onProgress?.listen((event) { });
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
      sampleRate: 8000
    );
    return true;
  }

  Future<String?> stopRecorder() async {
    String? url = await _soundRecorder.stopRecorder();
    return url;
  }

  void getDuration(String path) async {
    MediaInformation information = await _fFprobe.getMediaInformation(path);
    Map<dynamic, dynamic>? properties = information.getMediaProperties();
    properties?['duration'];
  }
}