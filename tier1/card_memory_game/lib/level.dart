enum Level {
  easy('Easy', 2, 100.0, 5000),
  medium('Medium', 4, 50.0, 60000),
  hard('Hard', 6, 35.0, 300000);

  const Level(this.description, this.columns, this.iconSize, this.timeLimit);

  final String description;
  final int columns;
  final double iconSize;
  final int timeLimit;
}
