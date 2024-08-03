import 'package:flutter/material.dart';

class ViSnackbar {
  static void showInfo(BuildContext context, String message) {
    _showSnackbar(
      context,
      title: 'Bilgi',
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackbar(
      context,
      title: 'Uyarı',
      message: message,
      backgroundColor: Colors.yellow,
      icon: Icons.warning,
    );
  }

  static void showError(BuildContext context, String message) {
    _showSnackbar(
      context,
      title: 'Error',
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(
      context,
      title: 'Success',
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void _showSnackbar(
    BuildContext context, {
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
