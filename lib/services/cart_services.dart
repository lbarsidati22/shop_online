import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
  Future<void> setCartItem(String userId, AddToCartModel cartItem);
}

class CartServicesEmpl implements CartServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async {
    return await firestoreServices.getCollection(
        path: ApiPaths.cartItems(userId),
        builder: (data, documentId) {
          return AddToCartModel.fromMap(data);
        });
  }

  @override
  Future<void> setCartItem(String userId, AddToCartModel cartItem) async {
    return firestoreServices.setData(
        path: ApiPaths.cartItem(userId, cartItem.id), data: cartItem.toMap());
  }
}
