enum Level {
  easy(2, 100.0),
  medium(4, 50.0),
  hard(6, 35.0);

  const Level(this.columns, this.iconSize);

  final int columns;
  final double iconSize;
}
