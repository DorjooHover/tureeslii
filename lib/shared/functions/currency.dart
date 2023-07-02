String currencyFormat(double value) {
  String result = '';
  double temp = value;
  while (temp ~/ 1000 > 0) {
    double temp2 = temp % 1000;
    String tempStr = '';
    if (temp2 == 0) {
      tempStr = '000';
    } else {
      tempStr = temp2.toStringAsFixed(0).toString();
    }
    if (result.length > 2) {
      result = "$tempStr'$result";
    } else {
      result = tempStr;
    }
    temp = temp / 1000;
  }
  result = "${temp.toStringAsFixed(0)}'$result";

  return result;
}
