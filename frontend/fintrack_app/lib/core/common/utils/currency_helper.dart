String sanitizeCurrencyCode(String currencyCode) {
  return currencyCode.split(RegExp(r'[\s\(]')).first;
}
