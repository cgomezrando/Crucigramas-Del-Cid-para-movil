// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future checkWin(BuildContext context) async {
  final data = FFAppState().currentCrosswordData;

  final Map<String, dynamic> answers = {};
  final raw = FFAppState().userAnswers;
  if (raw is Map) {
    raw.forEach((k, v) => answers[k.toString()] = v);
  }

  final int W = data.width;
  final grid = data.grid.toList();

  bool complete = true;
  bool correct = true;

  for (final cell in grid) {
    if (cell.type == 'letter') {
      final int idx = cell.row * W + cell.col;
      final userLetter =
          (answers[idx.toString()] ?? '').toString().toUpperCase();
      final correctLetter = cell.answer.toString().toUpperCase();

      if (userLetter.isEmpty) {
        complete = false;
      } else if (userLetter != correctLetter) {
        correct = false;
      }
    }
  }

  if (!complete || !correct) return;

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Dialog(
        backgroundColor: const Color(0xFFF5EFE0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events,
                  color: Color(0xFFC8A96B), size: 64),
              const SizedBox(height: 16),
              const Text('¡Enhorabuena!',
                  style: TextStyle(
                      color: Color(0xFF6B1F2C),
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              const SizedBox(height: 10),
              const Text('Has completado el crucigrama',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF7A5C5C), fontSize: 16)),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B1F2C),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14)),
                onPressed: () {
                  Navigator.pop(ctx);
                  FFAppState().isLoadingCrossword = false;
                  FFAppState().userAnswers = {};
                },
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
