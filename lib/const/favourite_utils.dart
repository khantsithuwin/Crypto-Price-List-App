import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  final String _favKey = 'fav';
  final String _themeKey = 'theme';
  SharedPreferences sharedPreferences = GetIt.instance.get<SharedPreferences>();

  bool isFavourite(String code) {
    List<String> isFav = getFavourite();
    return isFav.contains(code);
  }

  void saveFavourite(String code) {
    List<String> existingCode = getFavourite();
    sharedPreferences.setStringList(_favKey, [...existingCode, code]);
  }

  void removeFavourite(String code) {
    List<String> existingCode = getFavourite();
    existingCode.remove(code);
    sharedPreferences.setStringList(_favKey, existingCode);
  }

  List<String> getFavourite() {
    return sharedPreferences.getStringList(_favKey) ?? [];
  }

  void clearFavourites() {
    sharedPreferences.setStringList(_favKey, []);
  }

  void saveTheme(bool isDark) {
    sharedPreferences.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return sharedPreferences.getBool(_themeKey) ?? false;
  }
}
