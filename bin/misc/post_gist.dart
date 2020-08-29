import 'package:http/http.dart';
import 'config.dart' as config;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<Response> postGist(String content) async {
  final response = await http.post(
    'https://api.github.com/gists',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${config.ghToken}'
    },
    body: convert.jsonEncode(
      <String, dynamic>{
        'description': 'Someone generated this file',
        'public': false,
        'files': {
          'main.dart': {'content': '$content'}
        }
      },
    ),
  );
  return response;
}
