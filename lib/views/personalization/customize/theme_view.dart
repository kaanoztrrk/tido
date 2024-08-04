import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../blocs/theme_bloc/theme_event.dart';
import '../../../blocs/theme_bloc/theme_state.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  Color? _selectedColor;
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const ViAppBar(
              showBackArrow: true,
              centerTitle: true,
              title: Text("Theme"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(title: "Primary Color"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: ViSizes.defaultSpace),
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

                          final gradientIndex =
                              state.allColorList.indexOf(color);
                          if (gradientIndex != -1) {
                            final selectedGradient =
                                state.allGradientList[gradientIndex];
                            print(
                                'Selected Gradient: $selectedGradient, COLOR : $color');
                            context
                                .read<ThemeBloc>()
                                .add(ChangeThemeColorEvent(color));
                            context.read<ThemeBloc>().add(
                                ChangeButtonGradientEvent(selectedGradient));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? Border.all(color: AppColors.black, width: 3)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(title: "Primary Texture"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: ViSizes.defaultSpace),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.allTextureList.length,
                    itemBuilder: (context, index) {
                      final background = state.allTextureList[index];
                      final isSelected = background == _selectedImage;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = background;
                          });
                          context
                              .read<ThemeBloc>()
                              .add(ChangeBackgroundImageEvent(background));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(background),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? Border.all(color: AppColors.black, width: 3)
                                : null,
                          ),
                        ),
                      );
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
