import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime now = DateTime.now();
  final DateTime firstDate = DateTime(2020, 1, 1);
  final DateTime lastDate = DateTime(2025, 12, 31);

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: now,
  );

  return pickedDate;
}

String formatDate(DateTime date) => DateFormat('dd-MM-yyyy').format(date);

String formatDateWithMonth(DateTime date) =>
    DateFormat('dd MMM yyyy').format(date);
