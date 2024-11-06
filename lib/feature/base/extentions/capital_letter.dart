extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
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