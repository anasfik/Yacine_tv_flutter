extension StringExtension on String {
    String capitalizeAllWordsFirstLetter() {
    String lowerCasedString = toLowerCase();
    String stringWithoutExtraSpaces = lowerCasedString.trim();

    if (stringWithoutExtraSpaces.isEmpty) {
      return "";
    }
    if (stringWithoutExtraSpaces.length == 1) {
      return stringWithoutExtraSpaces.toUpperCase();
    }

    List<String> stringWordsList = stringWithoutExtraSpaces.split(" ");
    List<String> capitalizedWordsFirstLetter = stringWordsList
        .map(
          (word) {
            final trimmed = word.trim();

            if (trimmed.isEmpty) return "";

            return trimmed;
          },
        )
        .where(
          (word) => word != "",
        )
        .map(
          (word) {
            if (word.startsWith(RegExp(r'[\n\t\r]'))) {
              return word;
            }

            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          },
        )
        .toList();
    String finalResult = capitalizedWordsFirstLetter.join(" ");

    return finalResult;
  }
}