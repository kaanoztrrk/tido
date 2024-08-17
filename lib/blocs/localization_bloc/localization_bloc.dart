import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tido/blocs/localization_bloc/localization_state.dart';
import 'package:tido/data/models/language_model/language_model.dart';
import 'package:tido/utils/Constant/app_constants.dart';

part 'localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState()) {
    on<ChangeAppLocalization>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(
      ChangeAppLocalization event, Emitter<LocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(APPContants.languagePrefsKey,
        event.selectedLanguage.locale.languageCode);

    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  onGetLanguage(GetLanguage event, Emitter<LocalizationState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final selectedLanguage = prefs.getString(APPContants.languagePrefsKey);

    emit(
      state.copyWith(
        selectedLanguage: selectedLanguage != null
            ? LanguageModel.values
                .where((element) =>
                    element.locale.languageCode == selectedLanguage)
                .first
            : LanguageModel.english,
      ),
    );
  }
}
