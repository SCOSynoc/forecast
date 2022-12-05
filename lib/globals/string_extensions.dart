extension StringExtension on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    } on RangeError{
      return "Empty";
    }

  }
}