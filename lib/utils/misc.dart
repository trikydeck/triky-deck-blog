import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildCounter(context,
        {int currentLength, bool isFocused, int maxLength}) =>
    SizedBox.shrink();

Future<void> delay(int milli) async {
  await Future.delayed(Duration(milliseconds: milli));
}

Future<DateTime> pickDate(BuildContext context, {DateTime initialDate}) async {
  DateTime t = await showDatePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year - 1),
    initialDate: initialDate ?? DateTime.now(),
    lastDate: DateTime.now(),
  );
  return t;
}

///
/// 'd-M-yyyy h:mm a'
///
/// 'EEEE' day
///
String dateAsReadable(DateTime dateTime, {String format = "dd-MMM-yyyy"}) {
  DateFormat formatter = new DateFormat(format);
  return formatter.format(dateTime);
}

DateTime optimizeDate(DateTime d) {
  return DateTime(d.year, d.month, d.day);
}

String optiNo(double i) {
  String r = '';
  String t = i.toString();
  String decimal = '';
  if (t.contains('.')) {
    decimal = t.split('.').last;
  }
  t = t.split('.').first.split('').reversed.join();

  for (var i = 0; i < t.length; i++) {
    r += t[i];
    if (i == 2 && (i + 1 < t.length)) r += ',';
    if (i == 4 && (i + 1 < t.length)) r += ',';
    if (i == 6 && (i + 1 < t.length)) r += ',';
  }
  r = r.split('').reversed.join();

  if (decimal.isEmpty) {
    return r;
  }

  return r + '.' + decimal;
}
