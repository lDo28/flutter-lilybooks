part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;

  ChangeLanguage({@required this.languageCode});
}
