class Assets {
  Assets._();

  static const String _imagesPath = 'assets/images/';

  // Number images
  static const String one = '${_imagesPath}one.png';
  static const String two = '${_imagesPath}two.png';
  static const String three = '${_imagesPath}three.png';
  static const String four = '${_imagesPath}four.png';
  static const String five = '${_imagesPath}five.png';
  static const String six = '${_imagesPath}six.png';
  static const String sixer = '${_imagesPath}sixer.png';

  // Hand gesture images
  static const String hand1 = 'assets/images/1.png';
  static const String hand2 = 'assets/images/2.png';
  static const String hand3 = 'assets/images/3.png';
  static const String hand4 = 'assets/images/4.png';
  static const String hand5 = 'assets/images/5.png';
  static const String hand6 = 'assets/images/6.png';
  static const String hand0 = 'assets/images/0.png';

  // Game elements
  static const String ball = '${_imagesPath}ball.png';
  static const String batting = '${_imagesPath}batting.png';
  static const String background = '${_imagesPath}background.png';
  static const String out = '${_imagesPath}out.png';
  static const String youWon = '${_imagesPath}you_won.png';
  static const String gameDefend = '${_imagesPath}game_defend.png';

  // Get the asset path for a hand number
  static String getHandNumberAsset(int number) {
    switch (number) {
      case 1:
        return hand1;
      case 2:
        return hand2;
      case 3:
        return hand3;
      case 4:
        return hand4;
      case 5:
        return hand5;
      case 6:
        return hand6;
      default:
        return hand0;
    }
  }

  static String getNumberAsset(int number) {
    switch (number) {
      case 1:
        return one;
      case 2:
        return two;
      case 3:
        return three;
      case 4:
        return four;
      case 5:
        return five;
      case 6:
        return six;
      default:
        return one;
    }
  }

  // List of all number assets
  static List<String> get numberAssets => [
        one,
        two,
        three,
        four,
        five,
        six,
      ];
}
