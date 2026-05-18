class StringNormalizer {
  String normalize(String input) {
    String text = input.toLowerCase();
    text = text.replaceAll('ё', 'е');
    text = text.replaceAll('–', '-');
    text = text.replaceAll('—', '-');
    text = text.replaceAll(RegExp(r'\b(гр|г\.)\b'), 'г');
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    return text.trim();
  }
}
