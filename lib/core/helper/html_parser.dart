String? htmlParse(String? text) {
  return text?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
}
