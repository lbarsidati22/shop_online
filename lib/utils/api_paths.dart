class ApiPaths {
  static String users(String userId) => 'users/$userId';
  //user == collection & userId == docs,
  static String products() => 'products/';
  static String product(String prudactId) => 'products/$prudactId';
}
