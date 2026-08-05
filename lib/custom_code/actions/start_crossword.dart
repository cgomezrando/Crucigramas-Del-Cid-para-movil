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

Future startCrossword(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EFE0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _RotatingHourglass(),
              SizedBox(height: 20),
              Text(
                'Cargando crucigrama...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B1F2C),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  try {
    final response = await http.get(Uri.parse(
        'https://crossword-generator-865875655013.europe-west1.run.app/generate-crossword'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      FFAppState().currentCrosswordData =
          CrosswordDataStruct.fromMap(data as Map<String, dynamic>);
      FFAppState().userAnswers = {};
    }
  } catch (e) {}

  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  FFAppState().isLoadingCrossword = true;
  FFAppState().hasSavedGame = true;
}

class _RotatingHourglass extends StatefulWidget {
  const _RotatingHourglass();
  @override
  State<_RotatingHourglass> createState() => _RotatingHourglassState();
}

class _RotatingHourglassState extends State<_RotatingHourglass>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _c,
      child: const Icon(Icons.hourglass_bottom,
          size: 64, color: Color(0xFF6B1F2C)),
    );
  }
}
