extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return ''; // Return an empty string if the original string is empty.
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class CaplitalizeSentence{
  String capitalizeEachWord(String sentence) {
    List<String> words = sentence.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return capitalizedWords.join(' ');
  }
}