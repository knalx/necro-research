import 'package:flutter/material.dart';
import 'package:necro_research/base-management-screen.dart';
import 'package:necro_research/game-state-manager.dart';
import 'package:necro_research/minion-management-screen.dart';
import 'package:necro_research/research-tree-screen.dart';
import 'package:provider/provider.dart';

class GameOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Necromancer Empire'),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // TODO: Navigate to settings screen
                },
              ),
            ],
          ),
          body: Column(
            children: [
              _buildResourceBar(gameState),
              Expanded(
                child: Row(
                  children: [
                    _buildQuickAccessPanel(context),
                    Expanded(
                      child: _buildMainContentArea(gameState),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResourceBar(GameState gameState) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: gameState.resources.entries.map((entry) {
          return Expanded(
            child: Text(
              '${entry.key}: ${entry.value}',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickAccessPanel(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.black45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAccessButton(
            icon: Icons.people,
            label: 'Minions',
            onPressed: () =>
                _navigateToScreen(context, MinionManagementScreen()),
          ),
          _buildQuickAccessButton(
            icon: Icons.science,
            label: 'Research',
            onPressed: () => _navigateToScreen(context, ResearchTreeScreen()),
          ),
          _buildQuickAccessButton(
            icon: Icons.map,
            label: 'Map',
            onPressed: () {
              // TODO: Implement Map screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Map screen not implemented yet')),
              );
            },
          ),
          _buildQuickAccessButton(
            icon: Icons.build,
            label: 'Build',
            onPressed: () => _navigateToScreen(context, BaseManagementScreen()),
          ),
          _buildQuickAccessButton(
            icon: Icons.auto_fix_high,
            label: 'Spells',
            onPressed: () {
              // TODO: Implement Spells screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Spells screen not implemented yet')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Widget _buildMainContentArea(GameState gameState) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Empire Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
              'Buildings: ${gameState.buildings.where((b) => b.level > 0).length}'),
          Text('Total Minions: ${gameState.minions.length}'),
          Text(
              'Research Completed: ${gameState.researchItems.where((r) => r.isCompleted).length}'),
          SizedBox(height: 16),
          Text(
            'Resource Production (per second):',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...gameState.buildings
              .where((b) => b.level > 0)
              .expand((b) => b.getProduction().entries)
              .fold<Map<String, int>>({}, (map, entry) {
                map[entry.key] = (map[entry.key] ?? 0) + entry.value;
                return map;
              })
              .entries
              .map((entry) => Text('${entry.key}: +${entry.value}/s'))
              .toList(),
        ],
      ),
    );
  }
}
