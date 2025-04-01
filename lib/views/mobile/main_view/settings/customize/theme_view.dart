import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../../blocs/theme_bloc/theme_event.dart';
import '../../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../../common/styles/container_style.dart';
import '../../../../../common/widget/Text/title.dart';
import '../../../../../common/widget/appbar/appbar.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/locator/locator.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';
import 'widget/theme_tile.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  Color? _selectedColor;
  String? _selectedImage; // backgroundImage için

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
            body: ListView(
              children: [
                // Primary Color Section
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
                                    color: Colors
                                        .black, // Black border for selected item
                                    width: 3)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Texture Section
                Padding(
                  padding: const EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(title: "Texture"),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.allBackgroundList.length +
                        1, // +1 for "No Texture"
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // First item - "No Texture"
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImage =
                                  null; // Remove the background image selection
                            });

                            context
                                .read<ThemeBloc>()
                                .add(ChangeBackgroundImageEvent(''));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(20),
                              border: _selectedImage == null
                                  ? Border.all(
                                      color: Colors
                                          .black, // Black border for selected item
                                      width: 3)
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                'No Texture',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final image =
                            state.allBackgroundList[index - 1]; // Adjust index
                        final isSelected = image == _selectedImage;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImage = image;
                            });

                            context
                                .read<ThemeBloc>()
                                .add(ChangeBackgroundImageEvent(image));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? Border.all(
                                      color: Colors
                                          .black, // Black border for selected item
                                      width: 3)
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
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
