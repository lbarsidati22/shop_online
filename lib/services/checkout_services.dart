import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/payment_cart_model.dart';
import 'package:shop_online/services/firestor_services.dart';
import 'package:shop_online/utils/api_paths.dart';

abstract class CheckoutServices {
  Future<void> setCart(String userId, PaymentCartModel paymentCart);
  Future<List<PaymentCartModel>> fetchPaymentMethods(String userId,
      [bool chosen = false]);
  Future<PaymentCartModel> fetchSinglePaymentMethods(
      String userId, String paymentId);
}

class CheckoutServicesImpl implements CheckoutServices {
  final firestorServices = FirestoreServices.instance;
  @override
  Future<void> setCart(String userId, PaymentCartModel paymentCart) async {
    await firestorServices.setData(
        path: ApiPaths.paymentCart(userId, paymentCart.id),
        data: paymentCart.toMap());
  }

  @override
  Future<List<PaymentCartModel>> fetchPaymentMethods(String userId,
      [bool chosen = false]) async {
    return await firestorServices.getCollection(
      path: ApiPaths.paymentCarts(userId),
      builder: (data, docubmentId) => PaymentCartModel.fromMap(data),
      queryBuilder:
          chosen ? (query) => query.where('isChosen', isEqualTo: true) : null,
    );
  }

  @override
  Future<PaymentCartModel> fetchSinglePaymentMethods(
      String userId, String paymentId) async {
    return await firestorServices.getDocument(
        path: ApiPaths.paymentCart(userId, paymentId),
        builder: (data, documentId) => PaymentCartModel.fromMap(data));
  }
}
