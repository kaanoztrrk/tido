// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../core/l10n/l10n.dart';

class ViValidator {
  static String? validateEmptyText(
      BuildContext context, String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '${AppLocalizations.of(context)!.required} $fieldName';
    }
    return null;
  }

  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w*]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordTooShort;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context)!.passwordUppercase;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppLocalizations.of(context)!.passwordNumber;
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return AppLocalizations.of(context)!.passwordSpecialChar;
    }
    return null;
  }

  static String? validatePhoneNumber(BuildContext context, String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.phoneRequired;
    }
    final phoneReExp = RegExp(r'^\d{10}$');
    if (!phoneReExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalidPhoneNumber;
    }
    return null;
  }
}
