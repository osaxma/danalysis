// from: https://en.wikipedia.org/wiki/Box-drawing_character#Encodings
enum BoxDrawingStyle {
  heavy('┃', '━', '┣', '┗', '╾'),
  light('│', '─', '├', '└', '╴'),
  double('║', '═', '╠', '╚', '╴'),
  dashedLight('┊', '┈', '╎', '└', '╌'),
  dashedHeavy('┇', '┉', '╏', '┗', '╍'),
  ;

  final String vertical;
  final String horizontal;
  final String verticalAndRight;
  final String upAndRight;
  final String rightTip;

  const BoxDrawingStyle(
    this.vertical,
    this.horizontal,
    this.verticalAndRight,
    this.upAndRight,
    this.rightTip,
  );
}
