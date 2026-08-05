// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'dart:math';

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
              Text('Cargando crucigrama...',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B1F2C))),
            ],
          ),
        ),
      );
    },
  );

  FFAppState().userAnswers = <String, dynamic>{};

  try {
    final rnd = Random();
    final chunkIndex = rnd.nextInt(5);
    String jsonStr;
    if (chunkIndex == 0) {
      jsonStr = await crosswordData1();
    } else if (chunkIndex == 1) {
      jsonStr = await crosswordData2();
    } else if (chunkIndex == 2) {
      jsonStr = await crosswordData3();
    } else if (chunkIndex == 3) {
      jsonStr = await crosswordData4();
    } else {
      jsonStr = await crosswordData5();
    }

    final List pool = jsonDecode(jsonStr) as List;
    final c = (pool[rnd.nextInt(pool.length)] as Map).cast<String, dynamic>();

    final int w = (c['w'] as num).toInt();
    final int h = (c['h'] as num).toInt();
    final String g = c['g'] as String;

    final Map<int, int> numMap = {};
    for (final pair in (c['n'] as List)) {
      final p = pair as List;
      numMap[(p[0] as num).toInt()] = (p[1] as num).toInt();
    }

    // Construir grid directamente con GridCellStruct
    final List<GridCellStruct> grid = [];
    for (int i = 0; i < g.length; i++) {
      final ch = g[i];
      final row = i ~/ w;
      final col = i % w;
      if (ch == '#') {
        grid.add(GridCellStruct(
            row: row, col: col, type: 'block', answer: '', number: 0));
      } else {
        grid.add(GridCellStruct(
            row: row,
            col: col,
            type: 'letter',
            answer: ch,
            number: numMap[i] ?? 0));
      }
    }

    List<ClueStruct> mkClues(List raw, String dir) {
      final out = <ClueStruct>[];
      for (final item in raw) {
        final it = item as List;
        final indices = (it[2] as List).map((x) => (x as num).toInt()).toList();
        out.add(ClueStruct(
          number: (it[0] as num).toInt(),
          clue: it[1] as String,
          answer: '',
          length: indices.length,
          direction: dir,
          cellIndices: indices,
        ));
      }
      return out;
    }

    // Construir el CrosswordDataStruct directamente
    FFAppState().currentCrosswordData = CrosswordDataStruct(
      id: 'cw${DateTime.now().millisecondsSinceEpoch}',
      title: 'Crucigrama',
      width: w,
      height: h,
      grid: grid,
      cluesHorizontal: mkClues(c['ch'] as List, 'horizontal'),
      cluesVertical: mkClues(c['cv'] as List, 'vertical'),
    );
  } catch (e, st) {
    print('ERROR startCrossword: $e');
    print(st);
  }

  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  FFAppState().isLoadingCrossword = true;
  FFAppState().hasSavedGame = false;
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
            size: 64, color: Color(0xFF6B1F2C)));
  }
}
