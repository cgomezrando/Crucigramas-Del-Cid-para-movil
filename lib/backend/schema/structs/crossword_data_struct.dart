// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CrosswordDataStruct extends BaseStruct {
  CrosswordDataStruct({
    String? id,
    String? title,
    int? width,
    int? height,
    List<ClueStruct>? cluesHorizontal,
    List<ClueStruct>? cluesVertical,
    List<GridCellStruct>? grid,
  })  : _id = id,
        _title = title,
        _width = width,
        _height = height,
        _cluesHorizontal = cluesHorizontal,
        _cluesVertical = cluesVertical,
        _grid = grid;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "width" field.
  int? _width;
  int get width => _width ?? 0;
  set width(int? val) => _width = val;

  void incrementWidth(int amount) => width = width + amount;

  bool hasWidth() => _width != null;

  // "height" field.
  int? _height;
  int get height => _height ?? 0;
  set height(int? val) => _height = val;

  void incrementHeight(int amount) => height = height + amount;

  bool hasHeight() => _height != null;

  // "cluesHorizontal" field.
  List<ClueStruct>? _cluesHorizontal;
  List<ClueStruct> get cluesHorizontal => _cluesHorizontal ?? const [];
  set cluesHorizontal(List<ClueStruct>? val) => _cluesHorizontal = val;

  void updateCluesHorizontal(Function(List<ClueStruct>) updateFn) {
    updateFn(_cluesHorizontal ??= []);
  }

  bool hasCluesHorizontal() => _cluesHorizontal != null;

  // "cluesVertical" field.
  List<ClueStruct>? _cluesVertical;
  List<ClueStruct> get cluesVertical => _cluesVertical ?? const [];
  set cluesVertical(List<ClueStruct>? val) => _cluesVertical = val;

  void updateCluesVertical(Function(List<ClueStruct>) updateFn) {
    updateFn(_cluesVertical ??= []);
  }

  bool hasCluesVertical() => _cluesVertical != null;

  // "grid" field.
  List<GridCellStruct>? _grid;
  List<GridCellStruct> get grid => _grid ?? const [];
  set grid(List<GridCellStruct>? val) => _grid = val;

  void updateGrid(Function(List<GridCellStruct>) updateFn) {
    updateFn(_grid ??= []);
  }

  bool hasGrid() => _grid != null;

  static CrosswordDataStruct fromMap(Map<String, dynamic> data) =>
      CrosswordDataStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        width: castToType<int>(data['width']),
        height: castToType<int>(data['height']),
        cluesHorizontal: getStructList(
          data['cluesHorizontal'],
          ClueStruct.fromMap,
        ),
        cluesVertical: getStructList(
          data['cluesVertical'],
          ClueStruct.fromMap,
        ),
        grid: getStructList(
          data['grid'],
          GridCellStruct.fromMap,
        ),
      );

  static CrosswordDataStruct? maybeFromMap(dynamic data) => data is Map
      ? CrosswordDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'width': _width,
        'height': _height,
        'cluesHorizontal': _cluesHorizontal?.map((e) => e.toMap()).toList(),
        'cluesVertical': _cluesVertical?.map((e) => e.toMap()).toList(),
        'grid': _grid?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'width': serializeParam(
          _width,
          ParamType.int,
        ),
        'height': serializeParam(
          _height,
          ParamType.int,
        ),
        'cluesHorizontal': serializeParam(
          _cluesHorizontal,
          ParamType.DataStruct,
          isList: true,
        ),
        'cluesVertical': serializeParam(
          _cluesVertical,
          ParamType.DataStruct,
          isList: true,
        ),
        'grid': serializeParam(
          _grid,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static CrosswordDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      CrosswordDataStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        width: deserializeParam(
          data['width'],
          ParamType.int,
          false,
        ),
        height: deserializeParam(
          data['height'],
          ParamType.int,
          false,
        ),
        cluesHorizontal: deserializeStructParam<ClueStruct>(
          data['cluesHorizontal'],
          ParamType.DataStruct,
          true,
          structBuilder: ClueStruct.fromSerializableMap,
        ),
        cluesVertical: deserializeStructParam<ClueStruct>(
          data['cluesVertical'],
          ParamType.DataStruct,
          true,
          structBuilder: ClueStruct.fromSerializableMap,
        ),
        grid: deserializeStructParam<GridCellStruct>(
          data['grid'],
          ParamType.DataStruct,
          true,
          structBuilder: GridCellStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CrosswordDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CrosswordDataStruct &&
        id == other.id &&
        title == other.title &&
        width == other.width &&
        height == other.height &&
        listEquality.equals(cluesHorizontal, other.cluesHorizontal) &&
        listEquality.equals(cluesVertical, other.cluesVertical) &&
        listEquality.equals(grid, other.grid);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, title, width, height, cluesHorizontal, cluesVertical, grid]);
}

CrosswordDataStruct createCrosswordDataStruct({
  String? id,
  String? title,
  int? width,
  int? height,
}) =>
    CrosswordDataStruct(
      id: id,
      title: title,
      width: width,
      height: height,
    );
