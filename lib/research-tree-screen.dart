import 'package:flutter/material.dart';

class ResearchItem {
  final String name;
  final String description;
  final int cost;
  final List<String> prerequisites;
  bool isUnlocked;

  ResearchItem({
    required this.name,
    required this.description,
    required this.cost,
    this.prerequisites = const [],
    this.isUnlocked = false,
  });
}

class ResearchTreeScreen extends StatefulWidget {
  @override
  _ResearchTreeScreenState createState() => _ResearchTreeScreenState();
}

class _ResearchTreeScreenState extends State<ResearchTreeScreen> {
  List<ResearchItem> researchItems = [
    ResearchItem(
      name: "Basic Necromancy",
      description: "Learn the fundamentals of raising the dead.",
      cost: 100,
    ),
    ResearchItem(
      name: "Advanced Skeleton Crafting",
      description: "Create more durable and powerful skeletal minions.",
      cost: 250,
      prerequisites: ["Basic Necromancy"],
    ),
    ResearchItem(
      name: "Soul Extraction",
      description: "Extract souls from the living to power your spells.",
      cost: 500,
      prerequisites: ["Basic Necromancy"],
    ),
    ResearchItem(
      name: "Plague Magic",
      description: "Harness the power of disease and decay.",
      cost: 750,
      prerequisites: ["Basic Necromancy", "Soul Extraction"],
    ),
    // Add more research items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Research Tree'),
      ),
      body: ListView.builder(
        itemCount: researchItems.length,
        itemBuilder: (context, index) {
          return _buildResearchItem(researchItems[index]);
        },
      ),
    );
  }

  Widget _buildResearchItem(ResearchItem item) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(item.description),
            SizedBox(height: 8),
            Text('Cost: ${item.cost} Dark Energy'),
            SizedBox(height: 8),
            if (item.prerequisites.isNotEmpty)
              Text('Prerequisites: ${item.prerequisites.join(", ")}'),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text(item.isUnlocked ? 'Researched' : 'Research'),
              onPressed: item.isUnlocked
                  ? null
                  : () {
                      // TODO: Implement research logic
                      setState(() {
                        item.isUnlocked = true;
                      });
                    },
            ),
          ],
        ),
      ),
    );
  }
}
