class AppStateModel {
  final bool isDark;

  AppStateModel({this.isDark = false});

  AppStateModel copyWith({bool? isDark}) {
    return AppStateModel(isDark: isDark ?? this.isDark);
  }
}
