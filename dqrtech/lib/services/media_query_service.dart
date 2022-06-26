class MediaQueryService {
  double? _screenHeight;
  double? _screenWidth;
  late double proportionalSizeX;
  late double proportionalSizeY;

  init(double height, double width) {
    _screenHeight = height;
    _screenWidth = width;
    proportionalSizeX = width / 100;
    proportionalSizeY = height / 100;
  }

  double? getScreenHeight() {
    return _screenHeight;
  }

  double? getScreenWidth() {
    return _screenWidth;
  }

  double proportionalWidth(double percentage) {
    return proportionalSizeX * percentage;
  }

  double proportionalHeight(double percentage) {
    return proportionalSizeY * percentage;
  }
}
