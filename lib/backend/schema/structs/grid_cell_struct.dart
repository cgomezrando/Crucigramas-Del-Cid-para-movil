// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GridCellStruct extends BaseStruct {
  GridCellStruct({
    int? number,
    int? row,
    int? col,
    String? answer,
    String? type,
  })  : _number = number,
        _row = row,
        _col = col,
        _answer = answer,
        _type = type;

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  set number(int? val) => _number = val;

  void incrementNumber(int amount) => number = number + amount;

  bool hasNumber() => _number != null;

  // "row" field.
  int? _row;
  int get row => _row ?? 0;
  set row(int? val) => _row = val;

  void incrementRow(int amount) => row = row + amount;

  bool hasRow() => _row != null;

  // "col" field.
  int? _col;
  int get col => _col ?? 0;
  set col(int? val) => _col = val;

  void incrementCol(int amount) => col = col + amount;

  bool hasCol() => _col != null;

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  set answer(String? val) => _answer = val;

  bool hasAnswer() => _answer != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static GridCellStruct fromMap(Map<String, dynamic> data) => GridCellStruct(
        number: castToType<int>(data['number']),
        row: castToType<int>(data['row']),
        col: castToType<int>(data['col']),
        answer: data['answer'] as String?,
        type: data['type'] as String?,
      );

  static GridCellStruct? maybeFromMap(dynamic data) =>
      data is Map ? GridCellStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'number': _number,
        'row': _row,
        'col': _col,
        'answer': _answer,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'number': serializeParam(
          _number,
          ParamType.int,
        ),
        'row': serializeParam(
          _row,
          ParamType.int,
        ),
        'col': serializeParam(
          _col,
          ParamType.int,
        ),
        'answer': serializeParam(
          _answer,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static GridCellStruct fromSerializableMap(Map<String, dynamic> data) =>
      GridCellStruct(
        number: deserializeParam(
          data['number'],
          ParamType.int,
          false,
        ),
        row: deserializeParam(
          data['row'],
          ParamType.int,
          false,
        ),
        col: deserializeParam(
          data['col'],
          ParamType.int,
          false,
        ),
        answer: deserializeParam(
          data['answer'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GridCellStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GridCellStruct &&
        number == other.number &&
        row == other.row &&
        col == other.col &&
        answer == other.answer &&
        type == other.type;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([number, row, col, answer, type]);
}

GridCellStruct createGridCellStruct({
  int? number,
  int? row,
  int? col,
  String? answer,
  String? type,
}) =>
    GridCellStruct(
      number: number,
      row: row,
      col: col,
      answer: answer,
      type: type,
    );
