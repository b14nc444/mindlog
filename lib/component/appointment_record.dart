import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';

import '../model/appoinment_model.dart';
import '../service/audio_player.dart';
import '../service/audio_recorder.dart';
import 'package:path/path.dart' as p;

class appointmentRecord extends StatefulWidget {
  final Appointment appointment;

  const appointmentRecord({super.key, required this.appointment});

  @override
  State<appointmentRecord> createState() => _appointmentRecordState();
}

class _appointmentRecordState extends State<appointmentRecord> {
  late AudioRecorder audioRecorder = AudioRecorder();
  late AudioPlayer audioPlayer = AudioPlayer();

  bool isRecording = false;
  bool isRecorded = false;
  bool isPlaying = false;
  String audioPath = '';

  late Timer _timer;
  int _seconds = 0;

  RecordConfig config = RecordConfig(
    sampleRate: 44100,
  );

  @override
  void initState() {
    // audioRecord = Record();
    // audioPlayer = AudioPlayer();
    // isRecorded = false;
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), updateTimer);
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    audioPath = await getFilePath();

    try {
      if(await audioRecorder.hasPermission()) {
        await audioRecorder.start(config, path: audioPath);
        setState(() {
          isRecording = true;
        });
        print('Recording started');
      }
    }
    catch (e) {
      print('recording failed : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();
      setState(() {
        isRecording = false;
        isRecorded = true;
        audioPath = path!;
      });
      print('Recording stopped');
      print('path : $audioPath');
    }
    catch (e) {
      print('recording failed : $e');
    }
  }

  Future<void> playRecording() async {
    try {
      String audioUri = Platform.isAndroid ? 'file://$audioPath' : audioPath;
      Source audioSource = DeviceFileSource(audioUri);
      // Source audioSource = DeviceFileSource(audioPath);
      await audioPlayer.play(audioSource);
      // String? path = await audioRecorder.stop();
      setState(() {
        isPlaying = true;
        // audioPath = path!;
      });
      print('Recording played');
      print('path : $audioPath');
    }
    catch (e) {
      print('recording failed : $e');
    }
  }

  void updateTimer(Timer timer) {
    if (isRecording) {
      setState(() {
        _seconds++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isRecording ? Text('녹음을 하고 있어요', style : TextStyle(color: Colors.red)) :  // 녹음중
            isRecorded ? Text('AI 요약') :  // 녹음 완료
            Text('아직 녹음을 하지 않았어요'),  // 녹음 전
            Row(
              children: [
                Text(
                  isRecording ? _formatTime(_seconds) :  // 녹음중
                  isPlaying ? '재생중' :  // 재생중
                  isRecorded ? _formatTime(_seconds) :  // 녹음 완료
                  ''  // 녹음 전
                ),
                IconButton(
                    onPressed: isRecording ? stopRecording :  // 녹음중 : 정지
                      isPlaying ? startRecording :  // 재생중 : 정지(test 녹음)
                      isRecorded ? playRecording :  // 녹음 완료 : 재생
                      startRecording,  // 녹음 전 : 녹음
                    icon: isRecording ? Image.asset('assets/icons/stop_button.png') :  // 녹음중 : 정지
                      isPlaying ? Icon(Icons.stop_circle) :  // 재생중 : 정지
                      isRecorded ? Icon(Icons.play_circle_outline) :  // 녹음 완료 : 재생
                      Image.asset('assets/icons/record_button.png')  // 녹음 전 : 녹음
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}

Future<String> getFilePath() async {
  Directory directory = await getApplicationDocumentsDirectory();
  return p.join(
    directory.path,
    'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
  );

  // String appDocPath = appDocDir.path;
  // File file = new File('$appDocPath/test.wav');
  // String filePath = file.path; // 파일 이름 및 확장자 설정
  // return filePath;
}
//
//   ContextWrapper contextWrapper= new ContextWrapper(getApplicationContext());
//   File musicDirectory = contextWrapper.getExternalFilesDir(Environment.DIRECTORY_MUSIC);
//   File file = new File(musicDirectory,"testAudioFile.pcm");
//   String path = file.getPath();
//   Log.d(TAG, "File created at path:" + path);
//
//   return path;
// }