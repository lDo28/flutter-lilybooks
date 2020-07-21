part of 'theme_mode_bloc.dart';

@immutable
abstract class ThemeModeEvent {}

class ChangeThemeMode extends ThemeModeEvent {
  final ThemeMode mode;

  ChangeThemeMode({@required this.mode});
}
