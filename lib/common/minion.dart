class Minion {
  final String name;
  final String type;
  int level;
  Map<String, int> stats;

  Minion({
    required this.name,
    required this.type,
    required this.level,
    required this.stats,
  });
}

class MinionType {
  final String name;
  final String description;
  final Map<String, int> cost;
  final Map<String, int> baseStats;

  MinionType({
    required this.name,
    required this.description,
    required this.cost,
    required this.baseStats,
  });
}

Map<String, MinionType> minionTypes = {
  'Skeleton': MinionType(
    name: 'Skeleton',
    description: 'Basic undead warrior',
    cost: {'Corpses': 1, 'Dark Energy': 5},
    baseStats: {'Strength': 5, 'Dexterity': 3, 'Intelligence': 1},
  ),
  'Zombie': MinionType(
    name: 'Zombie',
    description: 'Durable but slow undead',
    cost: {'Corpses': 2, 'Dark Energy': 8},
    baseStats: {'Strength': 7, 'Dexterity': 2, 'Intelligence': 1},
  ),
  'Ghost': MinionType(
    name: 'Ghost',
    description: 'Spectral entity with magical abilities',
    cost: {'Corpses': 1, 'Dark Energy': 15},
    baseStats: {'Strength': 2, 'Dexterity': 6, 'Intelligence': 5},
  ),
};
