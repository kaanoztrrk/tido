// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../common/widget/button/ratio_button.dart';
import '../../../../utils/Constant/colors.dart';
import '../../../../utils/Device/device_utility.dart';

class ViProfileSelectionWidget extends StatefulWidget {
  const ViProfileSelectionWidget({super.key});

  @override
  _ViProfileSelectionWidgetState createState() =>
      _ViProfileSelectionWidgetState();
}

class _ViProfileSelectionWidgetState extends State<ViProfileSelectionWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_imageFile == null) return;

    try {
      User? user = _auth.currentUser;
      if (user == null) return;

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${user.uid}.jpg');
      await storageRef.putFile(File(_imageFile!.path));

      // Get image URL
      final imageUrl = await storageRef.getDownloadURL();

      // Update Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'profileImageUrl': imageUrl,
      });

      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile image updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () async {
            await _pickImage();
            if (_imageFile != null) {
              await _uploadProfileImage();
            }
          },
          child: ViRotioButton(
            hasImage: true,
            isNetworkImage: true,
            bgImage: _imageFile != null
                ? FileImage(File(_imageFile!.path))
                : const AssetImage('assets/images/default_user.png')
                    as ImageProvider,
            size: ViDeviceUtils.getScreenWidth(context) * 0.25,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ViRotioButton(
            size: 40,
            bgColor: Theme.of(context).primaryColor,
            child: const Icon(
              Iconsax.edit,
              color: AppColors.white,
              size: 20,
            ),
            onTap: () async {
              await _pickImage();
              if (_imageFile != null) {
                await _uploadProfileImage();
              }
            },
          ),
        ),
      ],
    );
  }
}
