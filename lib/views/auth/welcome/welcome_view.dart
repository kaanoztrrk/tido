import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tido/blocs/main_bloc/main_bloc.dart';
import 'package:tido/core/routes/routes.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/views/auth/welcome/widget/welcome_parts.dart';
import '../../../common/widget/button/primary_button.dart';
import '../../../core/l10n/l10n.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Device/device_utility.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnBoarding();
    }
  }

  void _completeOnBoarding() {
    // Burada onboarding tamamlandığında yapılacak işlemleri ekleyin.
    // Örneğin, kullanıcıyı giriş sayfasına yönlendirme.
    context.push(ViRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              WelcomePart(
                image: ViImages.welcome_parts_1,
                title: AppLocalizations.of(context)!.welcomePagePart_title_1,
                subtitle:
                    AppLocalizations.of(context)!.welcomePagePart_subtitle_1,
              ),
              WelcomePart(
                image: ViImages.welcome_parts_2,
                title: AppLocalizations.of(context)!.welcomePagePart_title_2,
                subtitle:
                    AppLocalizations.of(context)!.welcomePagePart_subtitle_2,
              ),
              WelcomePart(
                image: ViImages.welcome_parts_3,
                title: AppLocalizations.of(context)!.welcomePagePart_title_3,
                subtitle:
                    AppLocalizations.of(context)!.welcomePagePart_subtitle_3,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: ViDeviceUtils.getBottomNavigationBarHeigth() + 75,
              ),
              child: SmoothPageIndicator(
                effect: ExpandingDotsEffect(
                  activeDotColor:
                      dark ? AppColors.light : Theme.of(context).primaryColor,
                  dotHeight: 10,
                ),
                controller: _pageController,
                count: 3,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            left: 20,
            child: ViPrimaryButton(
              text: _currentPageIndex == 2
                  ? AppLocalizations.of(context)!.done
                  : AppLocalizations.of(context)!.continue_text,
              onTap: _nextPage,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(2);
                _completeOnBoarding();
              },
              child: Text(
                AppLocalizations.of(context)!.skip,
                style: dark
                    ? ViTextTheme.ligthTextTheme.headlineSmall
                        ?.copyWith(color: AppColors.primary)
                    : ViTextTheme.darkTextTheme.headlineSmall
                        ?.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
