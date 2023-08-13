String currencyFormat(double value, bool isD) {
  // String result = '';
  // int temp = int.parse(value.toStringAsFixed(0));
  // while (temp ~/ 1000 > 0) {
  //   result =
  //       "${temp.toString().substring(temp.toString().length - 3)}${isD ? "," : "'"}$result";

  //   temp = temp ~/ 1000;
  // }
  // result = "${temp.toStringAsFixed(0)}${isD ? "," : "'"}$result";

  // return result.substring(0, result.length - 1);

  return value
      .toInt()
      .toString()
      .split('')
      .reversed
      .join()
      .replaceAllMapped(
          RegExp(r".{3}"), (match) => "${match.group(0)}${isD ? "," : "'"}")
      .split('')
      .reversed
      .join();
}
