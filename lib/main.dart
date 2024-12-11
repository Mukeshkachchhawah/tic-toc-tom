import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_toc_tom/tic-tac_toe_screen.dart';

import 'provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TicTacToeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeScreen(),
    );
  }
}
