import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Constant/text_strings.dart';
import 'package:tido/views/auth/welcome/widget/welcome_dot_navigation.dart';
import 'package:tido/views/auth/welcome/widget/welcome_parts.dart';
import 'package:tido/views/auth/welcome/widget/welcome_next_button.dart';
import 'package:tido/views/auth/welcome/widget/welcome_skip_button.dart';

import '../../../blocs/main_bloc/main_bloc.dart';
import '../../../blocs/main_bloc/main_event.dart';

class WelcomeView extends StatelessWidget {
  final PageController pageController;

  const WelcomeView({
    required this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              context.read<MainBloc>().add(UpdatePageIndicator(index));
            },
            children: const [
              WelcomePart(
                  image: ViImages.welcome_parts_1,
                  title: ViTexts.welcomePagePart_title_1,
                  subtitle: ViTexts.welcomePagePart_subtitle_1),
              WelcomePart(
                  image: ViImages.welcome_parts_2,
                  title: ViTexts.welcomePagePart_title_2,
                  subtitle: ViTexts.welcomePagePart_subtitle_2),
              WelcomePart(
                  image: ViImages.welcome_parts_3,
                  title: ViTexts.welcomePagePart_title_3,
                  subtitle: ViTexts.welcomePagePart_subtitle_3),
            ],
          ),
          const WelcomeDotNavigation(),
          const WelcomeNextButton(),
          const WelcomeSkipButton()
        ],
      ),
    );
  }
}
