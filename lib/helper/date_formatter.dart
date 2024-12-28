import 'package:intl/intl.dart';

String formatDateTime(String apiDate) {
  // Parse the date string from the API (e.g., '2021-12-13T16:30:00Z')
  DateTime parsedDate = DateTime.parse(apiDate);

  // Format the date as '16:30 wed 13 2021'
  String formattedDate = DateFormat('HH : mm').format(parsedDate);

  return formattedDate;
}

String formatDateYear(String apiDate) {
  // Parse the date string from the API (e.g., '2021-12-13T16:30:00Z')
  DateTime parsedDate = DateTime.parse(apiDate);

  // Format the date as '16:30 wed 13 2021'
  String formattedDate = DateFormat('E dd yyyy').format(parsedDate);

  return formattedDate;
}
