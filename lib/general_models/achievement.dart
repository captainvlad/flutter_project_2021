class Achievement {
  final String name;
  final String description;
  final String imagePath;
  bool unlocked;

  Achievement({
    required this.name,
    required this.description,
    required this.imagePath,
    this.unlocked = false,
  });
}
