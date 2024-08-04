// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Snackbar/snacbar_service.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../utils/Constant/colors.dart';

class ViProfileImage extends StatefulWidget {
  const ViProfileImage({
    super.key,
    this.size = 55,
    this.onTap,
    this.child,
    this.bgColor,
    this.onEdit = false,
  });

  final double? size;
  final VoidCallback? onTap;
  final Widget? child;
  final Color? bgColor;
  final bool onEdit;

  @override
  State<ViProfileImage> createState() => _ViProfileImageState();
}

class _ViProfileImageState extends State<ViProfileImage> {
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<SignInBloc>().add(LoadUserProfileImage());
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      context.read<SignInBloc>().add(UploadProfileImage(_image!));
    } else {
      ViSnackbar.showWarning(context, " No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        String profileImageUrl = ViImages.default_user;

        if (state is ProfileImageLoaded) {
          profileImageUrl = state.profileImageUrl ?? ViImages.default_user;
        }

        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.bgColor ?? AppColors.ligthGrey.withOpacity(0.7),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _image == null
                        ? profileImageUrl.startsWith('http') ||
                                profileImageUrl.startsWith('https')
                            ? NetworkImage(profileImageUrl) as ImageProvider
                            : AssetImage(profileImageUrl) as ImageProvider
                        : FileImage(_image!),
                  ),
                  border: Border.all(width: 2, color: AppColors.white),
                ),
                child: widget.child,
              ),
            ),
            if (widget.onEdit)
              IconButton(
                onPressed: getImage,
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Iconsax.edit,
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
