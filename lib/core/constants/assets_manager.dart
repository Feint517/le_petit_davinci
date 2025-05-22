// ignore_for_file: constant_identifier_names

const String IMAGE_PATH = 'assets/images';
const String SVG_PATH = 'assets/svg';
const String ICONS_PATH = 'assets/icons';
const String LOTTIE_PATH = 'assets/lottie/misc';
const String ICON_PATH = 'assets/icons';


class ImageAssets {}

class LottieAssets {}

class IconAssets {}

class SvgAssets {
  // Splash screen assets
  static const String bgSplash = '$SVG_PATH/bg.svg';
  static const String letterA = '$SVG_PATH/A.svg';
  static const String letterB = '$SVG_PATH/B.svg';
  static const String letterC = '$SVG_PATH/C.svg';
  static const String bear = '$SVG_PATH/bearSplash.svg';
  static const String bird = '$SVG_PATH/birdSplash.svg';
  static const String choose = '$SVG_PATH/chooseSvg.svg';
  static const String logo = '$SVG_PATH/Logo.svg';
}

// Alias for easier access
class AssetsManager extends SvgAssets {}