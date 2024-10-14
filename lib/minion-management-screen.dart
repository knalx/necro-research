import 'package:flutter/material.dart';
import 'package:necro_research/common/minion.dart';
import 'package:necro_research/game-state-manager.dart';
import 'package:provider/provider.dart';

class MinionManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minion Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // TODO: Implement minion creation/summoning
              _showSummonMinionDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return ListView.builder(
            itemCount: gameState.minions.length,
            itemBuilder: (context, index) {
              return _buildMinionCard(
                  context, gameState.minions[index], gameState);
            },
          );
        },
      ),
    );
  }

  Widget _buildMinionCard(
      BuildContext context, Minion minion, GameState gameState) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(minion.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Level ${minion.level}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Text(minion.type,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            SizedBox(height: 8),
            ...minion.stats.entries
                .map((stat) => Text('${stat.key}: ${stat.value}'))
                .toList(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('Upgrade'),
                  onPressed: () {
                    // TODO: Implement upgrade logic
                    _showUpgradeMinionDialog(context, minion, gameState);
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Text('Assign Task'),
                  onPressed: () {
                    // TODO: Implement task assignment
                    _showAssignTaskDialog(context, minion, gameState);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSummonMinionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Summon New Minion'),
          content: Text('This feature is not implemented yet.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpgradeMinionDialog(
      BuildContext context, Minion minion, GameState gameState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upgrade ${minion.name}'),
          content: Text('This feature is not implemented yet.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAssignTaskDialog(
      BuildContext context, Minion minion, GameState gameState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assign Task to ${minion.name}'),
          content: Text('This feature is not implemented yet.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
