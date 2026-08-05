import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_currentCrosswordData')) {
        try {
          final serializedData =
              prefs.getString('ff_currentCrosswordData') ?? '{}';
          _currentCrosswordData = CrosswordDataStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_userAnswers')) {
        try {
          _userAnswers = jsonDecode(prefs.getString('ff_userAnswers') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _hasSavedGame = prefs.getBool('ff_hasSavedGame') ?? _hasSavedGame;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  CrosswordDataStruct _currentCrosswordData = CrosswordDataStruct();
  CrosswordDataStruct get currentCrosswordData => _currentCrosswordData;
  set currentCrosswordData(CrosswordDataStruct value) {
    _currentCrosswordData = value;
    prefs.setString('ff_currentCrosswordData', value.serialize());
  }

  void updateCurrentCrosswordDataStruct(
      Function(CrosswordDataStruct) updateFn) {
    updateFn(_currentCrosswordData);
    prefs.setString(
        'ff_currentCrosswordData', _currentCrosswordData.serialize());
  }

  dynamic _userAnswers;
  dynamic get userAnswers => _userAnswers;
  set userAnswers(dynamic value) {
    _userAnswers = value;
    prefs.setString('ff_userAnswers', jsonEncode(value));
  }

  dynamic _crosswordList;
  dynamic get crosswordList => _crosswordList;
  set crosswordList(dynamic value) {
    _crosswordList = value;
  }

  String _currentClue = '';
  String get currentClue => _currentClue;
  set currentClue(String value) {
    _currentClue = value;
  }

  bool _isLoadingCrossword = false;
  bool get isLoadingCrossword => _isLoadingCrossword;
  set isLoadingCrossword(bool value) {
    _isLoadingCrossword = value;
  }

  int _selectedNumber = 0;
  int get selectedNumber => _selectedNumber;
  set selectedNumber(int value) {
    _selectedNumber = value;
  }

  String _selectedDirection = '';
  String get selectedDirection => _selectedDirection;
  set selectedDirection(String value) {
    _selectedDirection = value;
  }

  List<int> _selectedIndices = [];
  List<int> get selectedIndices => _selectedIndices;
  set selectedIndices(List<int> value) {
    _selectedIndices = value;
  }

  void addToSelectedIndices(int value) {
    selectedIndices.add(value);
  }

  void removeFromSelectedIndices(int value) {
    selectedIndices.remove(value);
  }

  void removeAtIndexFromSelectedIndices(int index) {
    selectedIndices.removeAt(index);
  }

  void updateSelectedIndicesAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    selectedIndices[index] = updateFn(_selectedIndices[index]);
  }

  void insertAtIndexInSelectedIndices(int index, int value) {
    selectedIndices.insert(index, value);
  }

  bool _hasSavedGame = false;
  bool get hasSavedGame => _hasSavedGame;
  set hasSavedGame(bool value) {
    _hasSavedGame = value;
    prefs.setBool('ff_hasSavedGame', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
