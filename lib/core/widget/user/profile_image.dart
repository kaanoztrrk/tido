import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_event.dart';
import '../../../blocs/auth_blocs/sign_in_bloc/sign_in_state.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/image_strings.dart';
import '../../../utils/Snackbar/snacbar_service.dart';

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
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignInBloc>().add(LoadUserProfileImage());
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      context.read<SignInBloc>().add(UploadProfileImage(imageFile: _image!));
    } else {
      ViSnackbar.showWarning(context, "No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (state is ProfileImageLoaded) {
          _profileImageUrl = state.profileImageUrl;
        }

        String imageUrl = _image != null
            ? _image!.path
            : (_profileImageUrl ?? ViImages.default_user);

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
                  color: widget.bgColor ?? AppColors.lightGrey.withOpacity(0.7),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageUrl.startsWith('http') ||
                            imageUrl.startsWith('https')
                        ? NetworkImage(imageUrl) as ImageProvider
                        : (File(imageUrl).existsSync()
                            ? FileImage(File(imageUrl))
                            : AssetImage(ViImages.default_user)
                                as ImageProvider),
                  ),
                  border: Border.all(width: 2, color: AppColors.white),
                ),
                child: widget.child,
              ),
            ),
            if (widget.onEdit)
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  onPressed: getImage,
                  icon: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Iconsax.edit,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
