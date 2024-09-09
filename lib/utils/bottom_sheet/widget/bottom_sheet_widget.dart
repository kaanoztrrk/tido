import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
