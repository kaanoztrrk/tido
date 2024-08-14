import 'package:equatable/equatable.dart';

import '../../data/models/language_model/language_model.dart';

class LocalizationState extends Equatable {
  final LanguageModel selectedLanguage;

  LocalizationState({LanguageModel? language})
      : selectedLanguage = language ?? LanguageModel.english;

  @override
  List<Object?> get props => [selectedLanguage];

  LocalizationState copyWith({
    LanguageModel? selectedLanguage,
  }) {
    return LocalizationState(
      language: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
