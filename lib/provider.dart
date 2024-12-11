import 'package:flutter/material.dart';

class TicTacToeProvider with ChangeNotifier {
  List<Map<String, dynamic>> img = [
    {'img': 'assets/image/profile.png'}, // X profile image
    {'img': 'assets/image/profile1.png'} // O profile image
  ];

  List<String?> _board =
      List.filled(9, null); // Updated to hold image paths or null
  String _currentPlayer = "X";
  Map<String, int> _scores = {"X": 0, "O": 0};
  List<Map<String, dynamic>> _history = [];
  int _level = 1;

  List<String?> get board => _board;
  String get currentPlayer => _currentPlayer;
  Map<String, int> get scores => _scores;
  List<Map<String, dynamic>> get history => _history;
  int get level => _level;

  String get currentPlayerProfile =>
      _currentPlayer == "X" ? img[0]["img"] : img[1]["img"];

  void makeMove(int index) {
    if (_board[index] == null) {
      _board[index] = currentPlayerProfile;
      if (checkWinner()) {
        _scores[_currentPlayer] = (_scores[_currentPlayer] ?? 0) + 1;
        _history.add({
          "winner": _currentPlayer,
          "profileImage": currentPlayerProfile,
          "level": _level,
        });
        resetBoard();
      } else if (_board.every((cell) => cell != null)) {
        _history.add({
          "winner": "Draw",
          "profileImage": null,
          "level": _level,
        });
        resetBoard();
      } else {
        _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      }
      notifyListeners();
    }
  }

  bool checkWinner() {
    const winCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var combo in winCombos) {
      if (_board[combo[0]] != null &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]]) {
        return true;
      }
    }
    return false;
  }

  void resetBoard() {
    _board = List.filled(9, null);
    _currentPlayer = "X";
    notifyListeners();
  }

  void resetGame() {
    resetBoard();
    _scores = {"X": 0, "O": 0};
    _history.clear();
    _level = 1;
    notifyListeners();
  }

  void nextLevel() {
    _level++;
    resetBoard();
    notifyListeners();
  }
}
