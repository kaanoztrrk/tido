// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../blocs/theme_bloc/theme_event.dart';
import '../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../common/widget/Text/title.dart';
import '../../../../common/widget/appbar/appbar.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/locator/locator.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Constant/sizes.dart';
import 'widget/theme_tile.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: ViAppBar(
              showBackArrow: true,
              centerTitle: true,
              title: Text(AppLocalizations.of(context)!.theme),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(
                      title: AppLocalizations.of(context)!.primary_color),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.allColorList.length,
                    itemBuilder: (context, index) {
                      final color = state.allColorList[index];
                      final isSelected = color == _selectedColor;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });

                          context
                              .read<ThemeBloc>()
                              .add(ChangeThemeColorEvent(color));

                          context.pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 3)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(
                      title: AppLocalizations.of(context)!.theme_mode),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Light Mode
                      ThemeModeItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ChangeThemeModeEvent(ThemeMode.light)),
                        itemColor: Theme.of(context).primaryColor,
                        bgColor: const Color.fromARGB(255, 238, 225, 225),
                        title: AppLocalizations.of(context)!.light,
                        isSelected: state.themeMode == ThemeMode.light,
                      ),
                      // System Mode
                      ThemeModeSystemItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ChangeThemeModeEvent(ThemeMode.system)),
                        isSelected: state.themeMode == ThemeMode.system,
                      ),
                      // Dark Mode
                      ThemeModeItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ChangeThemeModeEvent(ThemeMode.dark)),
                        itemColor: Theme.of(context).primaryColor,
                        bgColor: AppColors.dark,
                        title: AppLocalizations.of(context)!.dark,
                        isSelected: state.themeMode == ThemeMode.dark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
