String toTitleCase(String value) {
  List<String> splitted = value.split(' ');

  return splitted.map((word) {
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}
