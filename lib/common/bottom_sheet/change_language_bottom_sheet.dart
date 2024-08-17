// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/localization_bloc/localization_bloc.dart';
import 'package:tido/blocs/localization_bloc/localization_state.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/core/l10n/l10n.dart';
import 'package:tido/data/models/language_model/language_model.dart';
import 'package:tido/utils/Constant/sizes.dart';

final class ChangeLanguageBottomSheet {
  static void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ViSizes.defaultSpace),
            child: Column(
              children: [
                ViPrimaryTitle(
                    title: AppLocalizations.of(context)!.chooseLanguage),
                const SizedBox(height: ViSizes.spaceBtwItems),
                BlocBuilder<LocalizationBloc, LocalizationState>(
                  buildWhen: (previous, current) =>
                      previous.selectedLanguage != current.selectedLanguage,
                  builder: (context, state) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final bool isLanguageChosen =
                            LanguageModel.values[index] ==
                                state.selectedLanguage;
                        return ListTile(
                          onTap: () {
                            context.read<LocalizationBloc>().add(
                                ChangeAppLocalization(
                                    selectedLanguage:
                                        LanguageModel.values[index]));

                            Future.delayed(const Duration(microseconds: 300))
                                .then((value) => context.pop());
                          },
                          leading: LanguageModel.values[index].image.image(
                            width: ViSizes.lg * 2,
                            height: ViSizes.lg * 2,
                          ),
                          title: Text(LanguageModel.values[index].text),
                          trailing: isLanguageChosen
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).primaryColor,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: isLanguageChosen
                                  ? BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.5)
                                  : BorderSide.none),
                          tileColor: isLanguageChosen
                              ? Theme.of(context).primaryColor.withOpacity(0.05)
                              : null,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ViSizes.defaultSpace),
                          child: Divider(),
                        );
                      },
                      itemCount: LanguageModel.values.length,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
