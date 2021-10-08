extension JetExtension on String {
  String get capitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get titleCase => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.capitalized)
      .join(" ");

  String get singular => substring(0, length - 1);

  String get sanitazedName => toLowerCase();

  String get plural => '${this}s';
}
