import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme_bloc/theme_bloc.dart';
import '../../blocs/theme_bloc/theme_state.dart';
import '../../core/locator/locator.dart';
import '../../utils/Constant/colors.dart';

class ViSwiperLayout extends StatelessWidget {
  const ViSwiperLayout({super.key, this.itemBuilder, this.itemCount});

  final Widget Function(BuildContext, int)? itemBuilder;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Swiper(
            itemBuilder: itemBuilder,
            itemCount: itemCount ?? 0,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: AppColors.darkGrey, // Normal dot color
                activeColor: state.primaryColor, // Active dot color
                size: 8.0, // Dot size
                activeSize: 10.0, // Active dot size
              ),
            ),
            layout: SwiperLayout.STACK,
            itemWidth: MediaQuery.of(context).size.width * 0.9,
            itemHeight: MediaQuery.of(context).size.height * 0.5,
            customLayoutOption:
                CustomLayoutOption(startIndex: -1, stateCount: 3)
                  ..addTranslate([
                    const Offset(0.0, -60.0),
                    const Offset(0.0, -40.0),
                    const Offset(0.0, -20.0),
                    const Offset(0.0, 0.0)
                  ])
                  ..addScale([0.8, 0.85, 0.9, 1.0], Alignment.topCenter),
          );
        },
      ),
    );
  }
}
