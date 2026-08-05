// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Custom Action: checkSavedGame
// Hay partida guardada si el usuario ha escrito alguna letra (userAnswers no vacio).
// Config: Include BuildContext OFF, Return Value OFF.

Future checkSavedGame() async {
  try {
    final raw = FFAppState().userAnswers;
    bool hasProgress = false;
    if (raw is Map && raw.isNotEmpty) {
      // hay progreso si alguna casilla tiene letra
      for (final v in raw.values) {
        if (v != null && v.toString().isNotEmpty) {
          hasProgress = true;
          break;
        }
      }
    }
    FFAppState().hasSavedGame = hasProgress;
  } catch (e) {
    FFAppState().hasSavedGame = false;
  }
}
