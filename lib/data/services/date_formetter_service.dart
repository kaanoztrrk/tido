import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatterService {
  final BuildContext context;

  DateFormatterService(this.context);

  String formatTaskTime(DateTime? dateTime) {
    final locale = Localizations.localeOf(context).toString();
    final format = DateFormat('HH:mm', locale);
    return dateTime != null ? format.format(dateTime) : '';
  }

  String formatDate(DateTime? dateTime) {
    final locale = Localizations.localeOf(context).toString();
    final format = DateFormat('yyyy-MM-dd', locale);
    return dateTime != null ? format.format(dateTime) : '';
  }
}
