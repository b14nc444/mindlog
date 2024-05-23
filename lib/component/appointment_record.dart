import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/record_model.dart';
import 'package:mindlog_app/provider/record_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';

import '../model/appoinment_model.dart';
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
  late StreamSubscription<PlayerState> playerStateSubscription;

  bool isRecorded = false;
  bool isRecording = false;
  bool isPlaying = false;
  bool isPaused = false;
  String audioPath = '';

  late Timer _timer;
  int _seconds = 0;

  RecordConfig config = RecordConfig(
    sampleRate: 44100,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), updateTimer);

    playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        // 재생이 완료되었을 때
        if(mounted) {
          setState(() {
            isPlaying = false;
          });
        }
        print('Playback completed');
      }
    });
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    _timer.cancel();

    if(mounted) {
      setState(() {
        isRecording = false;
      });
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = context.watch<RecordProvider>();
    int? recordId = 6; //widget.appointment.record_id;
    //record id 조회가 안 됨

    ///////쓰레기존///////
    if(recordId != null) {
      recordProvider.getRecordById(id: recordId);
    }
    Record? record = recordProvider.record;

    setState(() {
      isRecorded = record != null; // 녹음본이 있으면 isRecorded를 true로 설정
    });

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isRecorded
                    ? Text('AI 요약')  // 녹음 완료
                    : isRecording ? Text('녹음을 하고 있어요', style : TextStyle(color: Color(0xffff6362))) :  // 녹음 중
                      Text('아직 녹음을 하지 않았어요'),  // 녹음 전
                Row(
                  children: [
                    Text(
                      isRecorded
                          ? isPlaying ? '재생중' :  // 재생중
                            _formatTime(_seconds)  // 녹음 완료
                          : isRecording ? _formatTime(_seconds) :  // 녹음 중
                            ''  // 녹음 전
                    ),
                    IconButton(
                        onPressed:
                          isRecorded
                            ? isPlaying ?
                              isPaused ? resumePlaying : pausePlaying :  // 일시정지/재생중
                              startPlaying  // 녹음 완료: 재생
                            : isRecording ? stopRecording :  // 녹음 중 : 정지
                              startRecording,  // 녹음 전 : 녹음
                        icon:
                          isRecorded
                            ? isPlaying ?
                              isPaused ? Image.asset('assets/icons/play_button.png') : Image.asset('assets/icons/pause_button.png') :  // 일시정지/재생중
                              Image.asset('assets/icons/play_button.png')  // 녹음 완료: 재생
                            : isRecording ? Image.asset('assets/icons/stop_button.png') :  // 녹음중 : 정지
                              Image.asset('assets/icons/record_button.png')  // 녹음 전 : 녹음
                    ),
                  ],
                ),
              ],
            ),
            if (isRecording)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 280,
                      child: Image.asset('assets/icons/audio_spectrum.png')
                    ),
                    const SizedBox(height: 18,),
                    GestureDetector(
                      onTap: dispose,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close_rounded, color: basicGray,),
                          Text('녹음 취소하기', style: TextStyle(
                            color: basicGray
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if(isRecorded)
              Container(
                width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text('요약을 생성중입니다...'),
                  )
              )
          ],
        ),
      ),
    );
  }

  Future<void> startRecording() async {
    audioPath = await getFilePath(widget.appointment);

    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start(config, path: audioPath);
        if (mounted) {
          setState(() {
            isRecorded = false;
            isRecording = true;
          });
        }
        print('Recording started');
      }
    } catch (e) {
      print('Recording failed : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();
      if(mounted) {
        setState(() {
          isRecording = false;
          isRecorded = true;
          audioPath = path!;
        });
      }
      print('Recording stopped');
      print('path : $audioPath');

      context.read<RecordProvider>().createRecord(
          record: Record(id: widget.appointment.id, filePath: audioPath)
      );
    }
    catch (e) {
      print('recording failed : $e');
    }
  }

  Future<void> startPlaying() async {
    try {
      final file = File(audioPath);
      if(await file.exists()) {
        Source audioSource = DeviceFileSource(audioPath);
        await audioPlayer.play(audioSource);

        if(mounted) {
          setState(() {
            isPlaying = true;
            // audioPath = path!;
          });
        }
        print('Playing playing from path : $audioPath');
      } else {
        print('File does not exist: $audioPath');
      }
    }
    catch (e) {
      print('Playing failed : $e');
    }
  }

  Future<void> pausePlaying() async {
    await audioPlayer.pause();
    setState(() {
      isPaused = true;
    });
  }

  Future<void> resumePlaying() async {
    await audioPlayer.resume();
    setState(() {
      isPaused = false;
    });
  }

  Future<void> stopPlaying() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void updateTimer(Timer timer) {
    if (isRecording) {
      setState(() {
        _seconds++;
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}

Future<String> getFilePath(Appointment appointment) async {
  Directory directory = await getApplicationDocumentsDirectory();
  return p.join(
    directory.path,
    'audio_${appointment.date}_${appointment.id}.m4a',
  );
}