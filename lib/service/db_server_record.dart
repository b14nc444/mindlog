import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Future<void> uploadRecordedFileToServer() async {
//   // 녹음한 오디오 파일의 경로를 가져옴
//   String filePath = await getRecordedAudioFilePath();
//
//   // 파일을 열어 바이트로 읽음
//   File file = File(filePath);
//   List<int> fileBytes = await file.readAsBytes();
//
//   // 파일을 Base64로 인코딩
//   String base64String = base64Encode(fileBytes);
//
//   // JSON 객체 생성
//   Map<String, dynamic> requestBody = {
//     'fileName': 'recorded_audio.wav',
//     'fileData': base64String,
//   };
//
//   // 서버로 전송
//   var apiUrl = Uri.parse('https://example.com/upload');
//   var response = await http.post(
//     apiUrl,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(requestBody),
//   );
//
//   // 응답 확인
//   if (response.statusCode == 200) {
//     print('파일 업로드 성공');
//   } else {
//     print('파일 업로드 실패: ${response.reasonPhrase}');
//   }
// }
