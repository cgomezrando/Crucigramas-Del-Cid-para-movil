// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchCrossword() async {
  final String apiUrl =
      "https://crossword-generator-865875655013.europe-west1.run.app/generate-crossword";

  try {
    print("FETCH: iniciando peticion");
    final response = await http.get(Uri.parse(apiUrl));
    print("FETCH: status = ${response.statusCode}");
    print("FETCH: body = ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } catch (e) {
    print("FETCH ERROR: $e");
    return null;
  }
}
