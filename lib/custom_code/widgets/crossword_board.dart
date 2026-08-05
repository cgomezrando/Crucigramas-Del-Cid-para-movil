// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Custom Widget: CrosswordBoard
//
// Dibuja el crucigrama completo (grid + pistas), adaptandose a
// portrait (grid arriba, pistas abajo) o landscape (grid izquierda,
// pistas derecha). Permite tocar casillas para escribir y hacer zoom.
//
// Lee los datos de FFAppState().currentCrosswordData y
// FFAppState().userAnswers. No necesita parametros de datos.
//
// FlutterFlow config:
//   Width/Height: infinity
//   No requiere parametros (usa App State directamente).

class CrosswordBoard extends StatefulWidget {
  const CrosswordBoard({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  State<CrosswordBoard> createState() => _CrosswordBoardState();
}

class _CrosswordBoardState extends State<CrosswordBoard> {
  Map<String, String> answers = {};
  String _loadedId = '';

  void _syncFromState() {
    // Recarga las respuestas del estado cuando cambia el crucigrama
    final data = FFAppState().currentCrosswordData;
    final id = data.id ?? '';
    if (id != _loadedId) {
      _loadedId = id;
      answers = {};
      final raw = FFAppState().userAnswers;
      if (raw is Map) {
        raw.forEach((k, v) => answers[k.toString()] = v.toString());
      }
    }
  }

  void _save() {
    FFAppState().userAnswers = Map<String, dynamic>.from(answers);
    FFAppState().hasSavedGame = true;
  }

  Color get granate => const Color(0xFF6B1F2C);
  Color get crema => const Color(0xFFF5EFE0);
  Color get cremaCell => const Color(0xFFFDFBF5);

  @override
  Widget build(BuildContext context) {
    _syncFromState();
    final data = FFAppState().currentCrosswordData;
    final int W = data.width;
    final int H = data.height;
    final grid = data.grid.toList();
    final cluesH = data.cluesHorizontal.toList();
    final cluesV = data.cluesVertical.toList();

    final gridWidget = _buildGrid(W, H, grid);
    final cluesWidget = _buildClues(cluesH, cluesV);

    final bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final content = landscape
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 7, child: gridWidget),
              const SizedBox(width: 12),
              Expanded(flex: 5, child: cluesWidget),
            ],
          )
        : Column(
            children: [
              Expanded(flex: 7, child: gridWidget),
              const SizedBox(height: 12),
              Expanded(flex: 4, child: cluesWidget),
            ],
          );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InteractiveViewer(
        minScale: 1.0,
        maxScale: 4.0,
        panEnabled: true,
        scaleEnabled: true,
        child: content,
      ),
    );
  }

  Widget _buildGrid(int W, int H, List grid) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Make the square as big as the smaller side allows
        final double side = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: side,
            height: side,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: W,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1,
              ),
              itemCount: grid.length,
              itemBuilder: (context, i) {
                final cell = grid[i];
                if (cell.type == 'block') {
                  return Container(color: const Color(0xFF2B2B2B));
                }
                final int num = cell.number;
                final String letter =
                    (answers[i.toString()] ?? '').toUpperCase();
                return GestureDetector(
                  onTap: () => _onCellTap(cell.number),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cremaCell,
                      border: Border.all(
                          color: const Color(0xFF7A5C5C), width: 0.5),
                    ),
                    child: Stack(
                      children: [
                        if (num > 0)
                          Positioned(
                            top: 1,
                            left: 2,
                            child: Text('$num',
                                style: TextStyle(
                                    fontSize: 9,
                                    color: granate,
                                    fontWeight: FontWeight.bold)),
                          ),
                        Center(
                          child: Text(letter,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: granate)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildClues(List cluesH, List cluesV) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _clueColumn('HORIZONTALES', cluesH)),
        const SizedBox(width: 8),
        Expanded(child: _clueColumn('VERTICALES', cluesV)),
      ],
    );
  }

  Widget _clueColumn(String title, List clues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: granate)),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: clues.length,
            itemBuilder: (context, i) {
              final c = clues[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                  onTap: () => _onCellTap(c.number),
                  child: Text('${c.number}. ${c.clue}',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF3A2A2A))),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _onCellTap(int cellNumber) async {
    if (cellNumber <= 0) return;
    final data = FFAppState().currentCrosswordData;

    dynamic clueH, clueV;
    for (final c in data.cluesHorizontal) {
      if (c.number == cellNumber) {
        clueH = c;
        break;
      }
    }
    for (final c in data.cluesVertical) {
      if (c.number == cellNumber) {
        clueV = c;
        break;
      }
    }
    if (clueH == null && clueV == null) return;

    dynamic chosen;
    if (clueH != null && clueV != null) {
      final dir = await showDialog<String>(
        context: context,
        builder: (ctx) => Dialog(
          backgroundColor: crema,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('Elige direccion',
                  style: TextStyle(
                      color: granate,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: granate),
                    onPressed: () => Navigator.pop(ctx, 'horizontal'),
                    child: const Text('Horizontal',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: granate),
                    onPressed: () => Navigator.pop(ctx, 'vertical'),
                    child: const Text('Vertical',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ]),
          ),
        ),
      );
      if (dir == null) return;
      chosen = dir == 'horizontal' ? clueH : clueV;
    } else {
      chosen = clueH ?? clueV;
    }

    await Future.delayed(const Duration(milliseconds: 120));

    final List indices = chosen.cellIndices.toList();
    String existing = '';
    for (final idx in indices) {
      existing += (answers[idx.toString()] ?? '');
    }
    final controller = TextEditingController(text: existing);
    final focusNode = FocusNode();

    final typed = await showDialog<String>(
      context: context,
      builder: (ctx) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => focusNode.requestFocus());
        return Dialog(
          backgroundColor: crema,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('$cellNumber. ${chosen.clue}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: granate,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(height: 8),
              Text('${chosen.length} letras',
                  style:
                      const TextStyle(color: Color(0xFF7A5C5C), fontSize: 14)),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                maxLength: chosen.length,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), counterText: ''),
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                    color: granate),
                onSubmitted: (v) => Navigator.pop(ctx, v),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: granate),
                    onPressed: () => Navigator.pop(ctx, null),
                    child: const Text('Cancelar',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: granate),
                    onPressed: () => Navigator.pop(ctx, controller.text),
                    child: const Text('Aceptar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );

    if (typed == null) return;
    final w = typed.toUpperCase().trim();
    for (int i = 0; i < indices.length; i++) {
      answers[indices[i].toString()] = i < w.length ? w[i] : '';
    }
    _save();
    setState(() {});
    _checkWin();
  }

  Future<void> _checkWin() async {
    final data = FFAppState().currentCrosswordData;
    final int W = data.width;
    bool complete = true, correct = true;
    for (final cell in data.grid) {
      if (cell.type == 'letter') {
        final idx = cell.row * W + cell.col;
        final u = (answers[idx.toString()] ?? '').toUpperCase();
        final a = cell.answer.toString().toUpperCase();
        if (u.isEmpty)
          complete = false;
        else if (u != a) correct = false;
      }
    }
    if (!complete || !correct) return;
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: crema,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.emoji_events, color: Color(0xFFC8A96B), size: 64),
            const SizedBox(height: 16),
            Text('¡Enhorabuena!',
                style: TextStyle(
                    color: granate, fontWeight: FontWeight.bold, fontSize: 26)),
            const SizedBox(height: 10),
            const Text('Has completado el crucigrama',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF7A5C5C), fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: granate),
              onPressed: () {
                Navigator.pop(ctx);
                FFAppState().isLoadingCrossword = false;
                FFAppState().userAnswers = {};
              },
              child: const Text('Continuar',
                  style: TextStyle(color: Colors.white)),
            ),
          ]),
        ),
      ),
    );
  }
}
