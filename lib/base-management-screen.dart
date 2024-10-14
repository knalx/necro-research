import 'package:flutter/material.dart';

class Building {
  final String name;
  final String description;
  final Map<String, int> cost;
  final Map<String, int> production;
  int level;

  Building({
    required this.name,
    required this.description,
    required this.cost,
    required this.production,
    this.level = 0,
  });

  Map<String, int> getUpgradeCost() {
    return cost.map((key, value) => MapEntry(key, (value * (level + 1)).ceil()));
  }

  Map<String, int> getProduction() {
    return production.map((key, value) => MapEntry(key, value * (level + 1)));
  }
}

class BaseManagementScreen extends StatefulWidget {
  @override
  _BaseManagementScreenState createState() => _BaseManagementScreenState();
}

class _BaseManagementScreenState extends State<BaseManagementScreen> {
  List<Building> buildings = [
    Building(
      name: "Crypt",
      description: "Generates corpses over time.",
      cost: {"Gold": 100},
      production: {"Corpses": 1},
    ),
    Building(
      name: "Dark Altar",
      description: "Generates dark energy over time.",
      cost: {"Gold": 150, "Corpses": 10},
      production: {"Dark Energy": 1},
    ),
    Building(
      name: "Necromancer's Tower",
      description: "Increases the power of your spells and rituals.",
      cost: {"Gold": 300, "Dark Energy": 50},
      production: {"Spell Power": 1},
    ),
    // Add more buildings as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base Management'),
      ),
      body: ListView.builder(
        itemCount: buildings.length,
        itemBuilder: (context, index) {
          return _buildBuildingCard(buildings[index]);
        },
      ),
    );
  }

  Widget _buildBuildingCard(Building building) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${building.name} (Level ${building.level})",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(building.description),
            SizedBox(height: 8),
            Text("Production: ${_formatResources(building.getProduction())}"),
            SizedBox(height: 8),
            Text("Upgrade Cost: ${_formatResources(building.getUpgradeCost())}"),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text(building.level == 0 ? 'Build' : 'Upgrade'),
              onPressed: () {
                // TODO: Implement build/upgrade logic
                setState(() {
                  building.level++;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatResources(Map<String, int> resources) {
    return resources.entries.map((e) => "${e.key}: ${e.value}").join(", ");
  }
}
