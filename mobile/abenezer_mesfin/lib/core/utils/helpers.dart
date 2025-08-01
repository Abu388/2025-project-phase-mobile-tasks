/// A collection of simple reusable helper functions.
/// You can import this file anywhere without affecting other logic.

class Helpers {
  /// Capitalizes the first letter of a string.
  static String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  /// Formats a price string with currency symbol.
  static String formatPrice(String price, {String symbol = '\$'}) {
    return '$symbol$price';
  }

  /// Returns a default image if the provided image path is empty.
  static String validateImage(String? path) {
    return (path == null || path.isEmpty)
        ? 'assets/images/default.jpg'
        : path;
  }
}
