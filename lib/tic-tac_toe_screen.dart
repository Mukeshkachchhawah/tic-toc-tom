import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class TicTacToeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<TicTacToeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Game History"),
                    content: SizedBox(
                      height: 500,
                      width: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: game.history.length,
                        itemBuilder: (context, index) {
                          final entry = game.history[index];
                          return ListTile(
                            leading: entry["profileImage"] != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        AssetImage(entry["profileImage"]),
                                  )
                                : const CircleAvatar(
                                    child: Icon(Icons.help),
                                  ),
                            title: Text(
                              "Level ${entry["level"]}: Winner: ${entry["winner"]}",
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Current Player Profile and Level
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Current Player: ${game.currentPlayer}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(game.currentPlayerProfile),
                    ),
                  ],
                ),
                Text(
                  "Level: ${game.level}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Scores
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Player X: ${game.scores["X"]}",
                    style: const TextStyle(fontSize: 18)),
                Text("Player O: ${game.scores["O"]}",
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
          // Board
          /* 
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => game.makeMove(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      game.board[index],
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
         */

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    game.makeMove(index);
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: game.board[index] == null
                        ? null
                        : Image.asset(
                            game.board[index]!,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),

          // Next Level Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: game.nextLevel,
              child: const Text("Next Level"),
            ),
          ),
        ],
      ),
    );
  }
}

/* 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_toc_tom/provider.dart';

class TicTacToeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Consumer<TicTacToeProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.makeMove(index);
                      },
                      child: Container(
                        color: Colors.grey[200],
                        child: provider.board[index] == null
                            ? null
                            : Image.asset(
                                provider.board[index]!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                ),
              ),
         
         
         
              Text(
                'Current Player: ${provider.currentPlayer}',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: provider.resetGame,
                child: Text('Reset Game'),
              ),
            ],
          );
        },
      ),
    );
  }
}
 */