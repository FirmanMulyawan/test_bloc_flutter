extension StringExt on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
