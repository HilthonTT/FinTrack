String formatEnumName(String name) {
  // Add spaces between camel case words
  String formattedName = name.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (Match match) => '${match.group(1)} ${match.group(2)}',
  );

  // Capitalize the first letter of the formatted name
  return formattedName[0].toUpperCase() + formattedName.substring(1);
}
