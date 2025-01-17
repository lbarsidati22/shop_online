class ApiPaths {
  static String users(String userId) => 'users/$userId';
  static String cartItem(String userId, String cartItemId) =>
      'users/$userId/cart/$cartItemId';
  static String favoritePrudact(String userId, String prudactId) =>
      'users/$userId/favorits/$prudactId';
  static String favoritePrudacts(String userId) => 'users/$userId/favorits/';
  static String products() => 'products/';
  static String announcements() => 'announcements/';
  static String categorises() => 'categorises/';
  static String product(String prudactId) => 'products/$prudactId';
}
