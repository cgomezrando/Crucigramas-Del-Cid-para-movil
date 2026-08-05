// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClueStruct extends BaseStruct {
  ClueStruct({
    int? number,
    String? clue,
    String? answer,
    int? length,
    String? direction,
    List<int>? cellIndices,
  })  : _number = number,
        _clue = clue,
        _answer = answer,
        _length = length,
        _direction = direction,
        _cellIndices = cellIndices;

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  set number(int? val) => _number = val;

  void incrementNumber(int amount) => number = number + amount;

  bool hasNumber() => _number != null;

  // "clue" field.
  String? _clue;
  String get clue => _clue ?? '';
  set clue(String? val) => _clue = val;

  bool hasClue() => _clue != null;

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  set answer(String? val) => _answer = val;

  bool hasAnswer() => _answer != null;

  // "length" field.
  int? _length;
  int get length => _length ?? 0;
  set length(int? val) => _length = val;

  void incrementLength(int amount) => length = length + amount;

  bool hasLength() => _length != null;

  // "direction" field.
  String? _direction;
  String get direction => _direction ?? '';
  set direction(String? val) => _direction = val;

  bool hasDirection() => _direction != null;

  // "cellIndices" field.
  List<int>? _cellIndices;
  List<int> get cellIndices => _cellIndices ?? const [];
  set cellIndices(List<int>? val) => _cellIndices = val;

  void updateCellIndices(Function(List<int>) updateFn) {
    updateFn(_cellIndices ??= []);
  }

  bool hasCellIndices() => _cellIndices != null;

  static ClueStruct fromMap(Map<String, dynamic> data) => ClueStruct(
        number: castToType<int>(data['number']),
        clue: data['clue'] as String?,
        answer: data['answer'] as String?,
        length: castToType<int>(data['length']),
        direction: data['direction'] as String?,
        cellIndices: getDataList(data['cellIndices']),
      );

  static ClueStruct? maybeFromMap(dynamic data) =>
      data is Map ? ClueStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'number': _number,
        'clue': _clue,
        'answer': _answer,
        'length': _length,
        'direction': _direction,
        'cellIndices': _cellIndices,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'number': serializeParam(
          _number,
          ParamType.int,
        ),
        'clue': serializeParam(
          _clue,
          ParamType.String,
        ),
        'answer': serializeParam(
          _answer,
          ParamType.String,
        ),
        'length': serializeParam(
          _length,
          ParamType.int,
        ),
        'direction': serializeParam(
          _direction,
          ParamType.String,
        ),
        'cellIndices': serializeParam(
          _cellIndices,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static ClueStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClueStruct(
        number: deserializeParam(
          data['number'],
          ParamType.int,
          false,
        ),
        clue: deserializeParam(
          data['clue'],
          ParamType.String,
          false,
        ),
        answer: deserializeParam(
          data['answer'],
          ParamType.String,
          false,
        ),
        length: deserializeParam(
          data['length'],
          ParamType.int,
          false,
        ),
        direction: deserializeParam(
          data['direction'],
          ParamType.String,
          false,
        ),
        cellIndices: deserializeParam<int>(
          data['cellIndices'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'ClueStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClueStruct &&
        number == other.number &&
        clue == other.clue &&
        answer == other.answer &&
        length == other.length &&
        direction == other.direction &&
        listEquality.equals(cellIndices, other.cellIndices);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([number, clue, answer, length, direction, cellIndices]);
}

ClueStruct createClueStruct({
  int? number,
  String? clue,
  String? answer,
  int? length,
  String? direction,
}) =>
    ClueStruct(
      number: number,
      clue: clue,
      answer: answer,
      length: length,
      direction: direction,
    );
