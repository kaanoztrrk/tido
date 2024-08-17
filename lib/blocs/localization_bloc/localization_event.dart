part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeAppLocalization extends LocalizationEvent {
  final LanguageModel selectedLanguage;

  const ChangeAppLocalization({required this.selectedLanguage});

  @override
  List<Object> get props => [selectedLanguage];
}

class GetLanguage extends LocalizationEvent {}
