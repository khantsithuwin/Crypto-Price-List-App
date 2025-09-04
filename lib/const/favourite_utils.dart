import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteUtils {
  final String _key = 'fav';
  SharedPreferences sharedPreferences = GetIt.instance.get<SharedPreferences>();

  bool isFavourite(String code) {
    List<String> isFav = getFavourite();
    return isFav.contains(code);
  }

  void saveFavourite(String code) {
    List<String> existingCode = getFavourite();
    sharedPreferences.setStringList(_key, [...existingCode, code]);
  }

  void removeFavourite(String code) {
    List<String> existingCode = getFavourite();
    existingCode.remove(code);
    sharedPreferences.setStringList(_key, existingCode);
  }

  List<String> getFavourite() {
    return sharedPreferences.getStringList(_key) ?? [];
  }
}
