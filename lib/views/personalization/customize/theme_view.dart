import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tido/blocs/main_bloc/main_bloc.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/common/widget/appbar/appbar.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Device/device_utility.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../blocs/theme_bloc/theme_event.dart';
import '../../../blocs/theme_bloc/theme_state.dart';
import '../../../core/locator/locator.dart';

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
                const Padding(
                  padding: EdgeInsets.all(ViSizes.defaultSpace),
                  child: ViPrimaryTitle(title: "Theme Mode"),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Light Mode
                      ThemeModeItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(ChangeThemeModeEvent(ThemeMode.light)),
                        itemColor: Theme.of(context).primaryColor,
                        bgColor: const Color.fromARGB(255, 219, 206, 206),
                        title: "Light",
                        isSelected: state.themeMode == ThemeMode.light,
                      ),
                      // System Mode
                      ThemeModeSystemItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(ChangeThemeModeEvent(ThemeMode.system)),
                        isSelected: state.themeMode == ThemeMode.system,
                      ),
                      // Dark Mode
                      ThemeModeItem(
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(ChangeThemeModeEvent(ThemeMode.dark)),
                        itemColor: Theme.of(context).primaryColor,
                        bgColor: AppColors.dark,
                        title: "Dark",
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

class ThemeModeItem extends StatelessWidget {
  const ThemeModeItem({
    super.key,
    this.bgColor,
    this.itemColor,
    required this.title,
    this.isSelected = false,
    this.onTap,
  });

  final Color? bgColor;
  final Color? itemColor;
  final String title;
  final bool isSelected;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(ViSizes.sm),
              height: ViDeviceUtils.getScreenHeigth(context) * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 3,
                ),
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0) +
                    const EdgeInsets.only(top: ViSizes.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: ViSizes.md),
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: ViSizes.md),
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                      width: ViDeviceUtils.getScreenWidth(context) * 0.2,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: itemColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}

class ThemeModeSystemItem extends StatelessWidget {
  const ThemeModeSystemItem({
    super.key,
    this.isSelected = false,
    this.onTap,
  });

  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(ViSizes.sm),
              height: ViDeviceUtils.getScreenHeigth(context) * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.light,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0) +
                        const EdgeInsets.only(top: ViSizes.sm),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: ViSizes.md),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: ViSizes.md),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 20,
                          width: ViDeviceUtils.getScreenWidth(context) * 0.2,
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text("System"),
        ],
      ),
    );
  }
}
