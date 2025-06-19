class PriceUtils {
  static String formatPrice(double price) {
    return price.toStringAsFixed(2);
  }
  static String getStringPrice(double price) {
    return '\$ ${price.toStringAsFixed(2)}';
  }
}