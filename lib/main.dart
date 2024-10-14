import 'package:flutter/material.dart';
import 'package:necro_research/common/AppTheme.dart';
import 'package:necro_research/game-overview-screen.dart';
import 'package:necro_research/game-state-manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Necromancer Research',
      debugShowCheckedModeBanner: false,
      theme: NecromancerTheme.darkTheme,
      home: GameOverviewScreen(), // Use the new screen as home
    );
  }
}

class NecromancerEmpireApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Necromancer Empire',
      theme: NecromancerTheme.darkTheme,
      home: GameOverviewScreen(),
    );
  }
}
