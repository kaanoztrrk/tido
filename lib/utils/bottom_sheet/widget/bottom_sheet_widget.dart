import 'dart:async';
import 'dart:io';

import 'package:TiDo/utils/Constant/image_strings.dart';
import 'package:TiDo/utils/Helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widget/item_tile/premium_item_tile.dart';
import '../../Constant/colors.dart';
import '../../Constant/sizes.dart';
import '../../Theme/custom_theme.dart/text_theme.dart';

class BottomSheetWidget {
  static Widget buildFileItem(String filePath) {
    final fileName = filePath.split('/').last;
    final fileExtension = fileName.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
      return Image.file(
        File(filePath),
        fit: BoxFit.cover,
      );
    } else {
      IconData iconData;
      switch (fileExtension) {
        case 'pdf':
          iconData = Icons.picture_as_pdf;
          break;
        case 'doc':
        case 'docx':
          iconData = Icons.description;
          break;
        default:
          iconData = Icons.insert_drive_file;
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: AppColors.white,
          ),
        ],
      );
    }
  }

  static Widget buildEditItem(BuildContext context, VoidCallback? ontap,
      bool dark, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (ontap != null) {
          ontap();
          context.pop();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: ViSizes.md),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: AppColors.darkerGrey,
              ),
              const SizedBox(width: ViSizes.lg),
              Text(
                title,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                      )
                    : ViTextTheme.ligthTextTheme.titleLarge?.copyWith(
                        color: AppColors.primaryText,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AutoSwipePageView extends StatefulWidget {
  @override
  _AutoSwipePageViewState createState() => _AutoSwipePageViewState();
}

class _AutoSwipePageViewState extends State<AutoSwipePageView> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSwipe();
  }

  // Starts the automatic page swiping
  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 4) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentPage++;
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ViHelpersFunctions.isDarkMode(context);
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal, // Horizontal scrolling
      children: [
        const PremiumItemTile(
          image: ViImages.theme,
          title: "Theme Customization",
          subTitle:
              "Unlock a personalized experience with various theme options.",
        ),
        const PremiumItemTile(
          image: ViImages.archive,
          title: "Archive View",
          subTitle: "Access and manage your past tasks with ease.",
        ),
        const PremiumItemTile(
          image: ViImages.cloud_sync,
          title: "Cloud Sync",
          subTitle:
              "Keep your tasks up-to-date across all devices with seamless cloud synchronization.",
        ),
        PremiumItemTile(
          image: dark ? ViImages.limitless_light : ViImages.limitless_dark,
          title: "Task Limit Control",
          subTitle:
              "Choose from 25, 50, or unlimited tasks to suit your needs.",
        ),
        const PremiumItemTile(
          image: ViImages.bio_password,
          title: "PIN and Biometric Login",
          subTitle:
              "Secure your app with PIN and biometric authentication for quick access.",
        ),
      ],
    );
  }
}
