import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  var themeText = "s";

  onChanged(newColor, n) {
    n == 1
        ? primaryColor = _setMaterialColor(newColor.hashCode)
        : accentColor = _setMaterialColor(newColor.hashCode);
    notifyListeners();
  }

  MaterialColor _setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(colorVal),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),
      },
    );
  }

  void themeModeChanged(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode tm) async {
    if (tm == ThemeMode.dark) {
      themeText = "d";
    } else if (tm == ThemeMode.light) {
      themeText = "l";
    } else if (tm == ThemeMode.system) {
      themeText = "s";
    }
    notifyListeners();
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";

    if (themeText == "d") {
      tm = ThemeMode.dark;
    } else if (themeText == "l") {
      tm = ThemeMode.light;
    } else if (themeText == "s") {
      tm = ThemeMode.system;
    }
    notifyListeners();
  }
}
