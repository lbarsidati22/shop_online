import 'package:shop_online/models/prudact_item_model.dart';

class AddToCartModel {
  final String id;
  final PrudactItemModel prudact;
  final PrudactSize size;
  final int quantity;

  AddToCartModel({
    required this.prudact,
    required this.id,
    required this.size,
    required this.quantity,
  });
  double get totalPrice => prudact.price * quantity;
}

List<AddToCartModel> dummyCart = [];
