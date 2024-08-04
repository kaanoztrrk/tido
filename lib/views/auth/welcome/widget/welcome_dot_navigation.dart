import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../blocs/main_bloc/main_bloc.dart';
import '../../../../blocs/main_bloc/main_event.dart';
import '../../../../blocs/main_bloc/main_state.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Device/device_utility.dart';
import '../../../../utils/Helpers/helpers_functions.dart';

class WelcomeDotNavigation extends StatelessWidget {
  const WelcomeDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: ViDeviceUtils.getBottomNavigationBarHeigth() + 75,
        ),
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return SmoothPageIndicator(
              effect: ExpandingDotsEffect(
                activeDotColor:
                    dark ? AppColors.light : Theme.of(context).primaryColor,
                dotHeight: 10,
              ),
              controller: context.read<MainBloc>().pageController,
              onDotClicked: (index) {
                context.read<MainBloc>().add(DoNavigationClick(index));
              },
              count: 3,
            );
          },
        ),
      ),
    );
  }
}
