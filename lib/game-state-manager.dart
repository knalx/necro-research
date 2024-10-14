import 'package:flutter/foundation.dart';
import 'package:necro_research/common/minion.dart';
import 'dart:async';

class GameState extends ChangeNotifier {
  Map<String, int> resources = {
    'Gold': 500,
    'Corpses': 10,
    'Dark Energy': 20,
  };

  List<Building> buildings = [];
  List<Minion> minions = [];
  List<ResearchItem> researchItems = [];

  Timer? _resourceTimer;

  GameState() {
    _initializeBuildings();
    _initializeResearch();
    _startResourceTimer();
  }

  void _initializeBuildings() {
    buildings = [
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
    ];
  }

  void _initializeResearch() {
    researchItems = [
      ResearchItem(
        name: "Basic Necromancy",
        description: "Learn the fundamentals of raising the dead.",
        cost: 100,
        unlockRequirement: () => true, // Always available
      ),
      ResearchItem(
        name: "Advanced Skeleton Crafting",
        description: "Create more durable and powerful skeletal minions.",
        cost: 250,
        unlockRequirement: () => isResearchCompleted("Basic Necromancy"),
      ),
      ResearchItem(
        name: "Soul Extraction",
        description: "Extract souls from the living to power your spells.",
        cost: 500,
        unlockRequirement: () => isResearchCompleted("Basic Necromancy"),
      ),
      ResearchItem(
        name: "Plague Magic",
        description: "Harness the power of disease and decay.",
        cost: 750,
        unlockRequirement: () =>
            isResearchCompleted("Basic Necromancy") &&
            isResearchCompleted("Soul Extraction"),
      ),
    ];
  }

  void _startResourceTimer() {
    _resourceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateResources();
    });
  }

  void _updateResources() {
    for (var building in buildings) {
      if (building.level > 0) {
        building.getProduction().forEach((resource, amount) {
          resources[resource] = (resources[resource] ?? 0) + amount;
        });
      }
    }
    notifyListeners();
  }

  bool canAfford(Map<String, int> cost) {
    return cost.entries
        .every((entry) => (resources[entry.key] ?? 0) >= entry.value);
  }

  void spendResources(Map<String, int> cost) {
    if (!canAfford(cost)) return;
    cost.forEach((resource, amount) {
      resources[resource] = (resources[resource] ?? 0) - amount;
    });
    notifyListeners();
  }

  bool canSummonMinion(String minionTypeName) {
    MinionType? minionType = minionTypes[minionTypeName];
    if (minionType == null) return false;
    return canAfford(minionType.cost);
  }

  void summonMinion(String minionTypeName) {
    MinionType? minionType = minionTypes[minionTypeName];
    if (minionType == null || !canSummonMinion(minionTypeName)) return;

    spendResources(minionType.cost);

    String minionName = '${minionType.name} ${minions.length + 1}';
    minions.add(Minion(
      name: minionName,
      type: minionTypeName,
      level: 1,
      stats: Map.from(minionType.baseStats),
    ));

    notifyListeners();
  }

  void upgradeBuilding(Building building) {
    if (canAfford(building.getUpgradeCost())) {
      spendResources(building.getUpgradeCost());
      building.level++;
      notifyListeners();
    }
  }

  bool isResearchCompleted(String researchName) {
    return researchItems
        .any((item) => item.name == researchName && item.isCompleted);
  }

  void performResearch(String researchName) {
    var research =
        researchItems.firstWhere((item) => item.name == researchName);
    if (research.canResearch(this)) {
      resources['Dark Energy'] = resources['Dark Energy']! - research.cost;
      research.isCompleted = true;
      notifyListeners();
      // You might want to add effects of the research here
    }
  }

  @override
  void dispose() {
    _resourceTimer?.cancel();
    super.dispose();
  }
}

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
    return cost
        .map((key, value) => MapEntry(key, (value * (level + 1)).ceil()));
  }

  Map<String, int> getProduction() {
    return production.map((key, value) => MapEntry(key, value * (level + 1)));
  }
}

class ResearchItem {
  final String name;
  final String description;
  final int cost;
  final Function unlockRequirement;
  bool isCompleted = false;

  ResearchItem({
    required this.name,
    required this.description,
    required this.cost,
    required this.unlockRequirement,
  });

  bool canResearch(GameState gameState) {
    return unlockRequirement() && gameState.resources['Dark Energy']! >= cost;
  }
}
