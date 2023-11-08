String currencyFormat(double value, bool isD) {
  String result = '';
  int temp = int.parse(value.toStringAsFixed(0));
  while (temp ~/ 1000 > 0) {
    result =
        "${temp.toString().substring(temp.toString().length - 3)}${isD ? "," : "'"}$result";

    temp = temp ~/ 1000;
  }
  result = "${temp.toStringAsFixed(0)}${isD ? "," : "'"}$result";

  return result.substring(0, result.length - 1);
}

String dateFormat(DateTime date) {
  int year = date.year;
  int month = date.month;
  int day = date.day;
  String monthStr = month < 10 ? '0$month' : '$month';
  String dayStr = day < 10 ? '0$day' : day.toString(); 
  return '$year.$monthStr.$dayStr';
}
