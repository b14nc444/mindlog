//진료상세 - 녹음 모델 완성되면 import
import 'package:http/http.dart' as http;
import 'dart:convert';

String sumUrl = 'https://naveropenapi.apigw.ntruss.com/text-summary/v1/summarize';
String clova_id = "iy9s7bv5n5";
String clova_secret = "wBn7qNhQ0MdUSKkugj9fJdrfKQSvTMu109g9ojZ6";

Future<String> clovaSummary() async {  //녹음기록을 인자로 받아와야..?
  var url = sumUrl;
  var request_headers={
    'Accept': 'application/json;UTF-8',
    'Content-Type': 'application/json;UTF-8',
    'X-NCP-APIGW-API-KEY-ID': clova_id,
    'X-NCP-APIGW-API-KEY': clova_secret,
  };
  var request_body = {
    "document": {
      "content": '' //녹음기록
    },
    "option": {
      "language": "ko",
      "model": "general",    // news(뉴스) / general(일반 문서)
      "tone": 0,  // 결과 어투: 원문(0) / 해요체(1) / 정중체(2) / 음슴체(3)
      "summaryCount": 1   // 요약문장 수
    }
  };
  var post = await http.post(Uri.parse(url), headers: request_headers, body: request_body);
  var result = jsonDecode(post.body);

  return result["summary"];

}