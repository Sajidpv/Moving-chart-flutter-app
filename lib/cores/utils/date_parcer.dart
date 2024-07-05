List<String> formatDateTime(DateTime date) {
  final dateTime = date.toLocal();
  String year = dateTime.year.toString();
  String month = dateTime.month.toString().padLeft(2, '0');
  String day = dateTime.day.toString().padLeft(2, '0');

  return [year, '$day-$month'];
}
