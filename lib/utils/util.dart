bool isInteger(num value) => value is int || value == value.roundToDouble();

String nbCoinsFormated(double nbCoins) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  return isInteger(nbCoins) ? nbCoins.toInt().toString() : nbCoins.toStringAsFixed(4).replaceAll(regex, '');
}
