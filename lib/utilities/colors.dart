import 'package:aapka_vakeel/others/shared_pref.dart';
import 'package:flutter/material.dart';

enum Themes {
  blueLight, //light and blue
  blueDark, //dark and blue
  nord, //blue grey, black
  shadow, //b&w
  modernInk, //orange, grey and black
  defaultTheme, //red and black
}

class AppColor {
  static String currentTheme = "no";
  static setCurrentTheme() async {
    String currentyheme = await MySharedPreferences.instance.getTheme();
    currentTheme = currentyheme;
    print("set $currentTheme");
    return true;
  }

  static Map<String, Color> lBlueMap = {
    "bgColor": const Color(0xFFffffff),
    "secondaryColor": const Color(0xFFf8f8f8),
    "tertiaryColor": const Color(0xFF0099ED),
    "primaryTextColor": const Color(0xFF1c1c1c),
    "secondaryTextColor": const Color(0xFFb4b4b4),
    "tertiaryTextColor": const Color(0xFFffffff),
    "treeLabelTextColor": const Color(0xFF4A5673),
    "treeBackColor": const Color(0xFFe5f6ff),
    "IconColor": const Color(0xFF4F535C),
    "textFieldColor": const Color.fromARGB(255, 197, 198, 201),
  };
  static Map<String, Color> dBlueMap = {
    "bgColor": Color.fromARGB(255, 255, 255, 255),
    "secondaryColor": Color.fromARGB(255, 255, 255, 255),
    "tertiaryColor": Color.fromARGB(255, 1, 1, 1),
    "primaryTextColor": Color(0xFF000000), //blueDark
    "secondaryTextColor": Color.fromARGB(255, 77, 78, 79), //blueDark
    "tertiaryTextColor": Color.fromARGB(255, 255, 255, 255), //blueDark
    "treeLabelTextColor": const Color(0xFFffffff),
    "treeBackColor": const Color(0xFF04567f),
    "IconColor": Color.fromARGB(255, 44, 44, 44),
    "textFieldColor": Color(0xffececec),
  };
  static Map<String, Color> lRedMap = {
    "bgColor": const Color(0xFFffffff),
    "secondaryColor": const Color(0xFFececec),
    "tertiaryColor": const Color(0xFFEF4F5F),
    "primaryTextColor": const Color(0xFF595959), //blueDark
    "secondaryTextColor": const Color(0xFFb7b7b7), //blueDark
    "tertiaryTextColor": const Color(0xFFffffff), //blueDark
    "treeLabelTextColor": const Color(0xFF4A5673),
    "treeBackColor": const Color(0xFFf8f3f5),
    "IconColor": const Color(0xFF4F535C),
    "textFieldColor": const Color.fromARGB(255, 197, 198, 201),
  };
  static Map<String, Color> dRedMap = {
    "bgColor": const Color(0xFF1D1D1D),
    "secondaryColor": const Color(0xFF111111),
    "tertiaryColor": const Color(0xFFEF4F5F),
    "primaryTextColor": const Color(0xFFffffff), //blueDark
    "secondaryTextColor": const Color(0xFF595959), //blueDark
    "tertiaryTextColor": const Color(0xFFffffff),
    "treeLabelTextColor": const Color(0xFFffffff),
    "treeBackColor": const Color.fromARGB(157, 252, 0, 25),
    "IconColor": const Color(0xFFF2F2F2),
    "textFieldColor": const Color.fromARGB(255, 57, 57, 57),
  };
  static Map<String, Color> lPurpleMap = {
    "bgColor": const Color(0xFFffffff),
    "secondaryColor": const Color(0xFFf8f8f8),
    "tertiaryColor": const Color(0xFF655BEF),
    "primaryTextColor": const Color(0xFF1c1c1c),
    "secondaryTextColor": const Color(0xFFb4b4b4),
    "tertiaryTextColor": const Color(0xFFffffff),
    "treeLabelTextColor": const Color(0xFF4A5673),
    "treeBackColor": const Color(0xFFf0effd),
    "IconColor": const Color(0xFF4F535C),
    "textFieldColor": const Color.fromARGB(255, 197, 198, 201)
  };
  static Map<String, Color> dPurpleMap = {
    "bgColor": const Color(0xFF1D1D1D),
    "secondaryColor": const Color(0xFF111111),
    "tertiaryColor": const Color(0xFF655BEF),
    "primaryTextColor": const Color(0xFFffffff), //blueDark
    "secondaryTextColor": const Color(0xFF595959), //blueDark
    "tertiaryTextColor": const Color(0xFFffffff),
    "treeLabelTextColor": const Color(0xFFffffff),
    "treeBackColor": const Color(0xFF4a5878),
    // "treeBackColor": const Color(0xFF502773),
    "IconColor": const Color(0xFFF2F2F2),
    "textFieldColor": const Color.fromARGB(255, 58, 58, 58),
  };

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static Color bgColor = getThemeColor("bgColor");

  static Color secondaryColor = getThemeColor("secondaryColor");

  static Color tertiaryColor = getThemeColor("tertiaryColor");

  static Color primaryTextColor = getThemeColor("primaryTextColor");
  static Color secondaryTextColor = getThemeColor("secondaryTextColor");
  static Color textFieldColor = getThemeColor("textFieldColor");
  static Color tertiaryTextColor = getThemeColor("tertiaryTextColor");
  static Color treeViewTextColor = getThemeColor("treeLabelTextColor");
  static Color treeBackColor = getThemeColor("treeBackColor");
  static Color iconColor = getThemeColor("IconColor");
  static Color connectedCameraColor = const Color(0xFF4caf50);
  static Color disconnectedCameraColor = const Color(0xFFf44336);

  static Color getThemeColor(String key) {
    if (currentTheme == Themes.blueLight.name) {
      return lBlueMap[key]!;
    } else if (currentTheme == Themes.blueDark.name) {
      return dBlueMap[key]!;
    } else if (currentTheme == Themes.nord.name) {
      return lPurpleMap[key]!;
    } else if (currentTheme == Themes.shadow.name) {
      return dPurpleMap[key]!;
    } else if (currentTheme == Themes.modernInk.name) {
      return lRedMap[key]!;
    } else {
      return dRedMap[key]!;
    }
  }
}
