import 'package:testt/util/colors.dart';
import 'package:testt/util/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:get_storage/get_storage.dart';

class TAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color(0xffE4003A),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TtextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Color(0xffE4003A),
      scaffoldBackgroundColor: TColors.dark,
      textTheme: TtextTheme.darkTextTheme);
}

// class ThemeProvider with ChangeNotifier {
//   ThemeData _themeData = TAppTheme.lightTheme;
  

//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }

//   void toogleTheme() {
//     if (_themeData == TAppTheme.lightTheme) {
//       themeData = TAppTheme.darkTheme;
//     }else{
//       themeData = TAppTheme.lightTheme;
//     }
//   }
// }



class ThemeProvider extends ChangeNotifier {
  final GetStorage _box = GetStorage();
  late ThemeData _themeData;

  ThemeProvider() {
    _initializeTheme();
  }

  ThemeData get themeData => _themeData;

  void _initializeTheme() {
    bool isLightTheme = _box.read('isLightTheme') ?? false;
    _themeData = isLightTheme ? TAppTheme.lightTheme : TAppTheme.darkTheme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == TAppTheme.lightTheme) {
      _themeData = TAppTheme.darkTheme;
      _box.write('isLightTheme', false);
    } else {
      _themeData = TAppTheme.lightTheme;
      _box.write('isLightTheme', true);
    }
    notifyListeners();
  }
}
