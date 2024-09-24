import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/language_model/language_model.dart';
import '../../utils/Constant/app_constants.dart';
import 'localization_state.dart';

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

    // Kullanıcının seçtiği dile göre zaman dilimini ayarlıyoruz
    if (event.selectedLanguage.locale.languageCode == 'en') {
      tz.setLocalLocation(tz.getLocation('America/New_York'));
    } else if (event.selectedLanguage.locale.languageCode == 'tr') {
      tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));
    } else if (event.selectedLanguage.locale.languageCode == 'de') {
      tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
    }

    // Zaman dilimini test etme
    print('Zaman dilimi: ${tz.local.name}');
    print('Şu anki saat: ${tz.TZDateTime.now(tz.local)}');

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
