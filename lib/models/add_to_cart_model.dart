import 'package:shop_online/models/prudact_item_model.dart';

class AddToCartModel {
  final String prudactId;
  final PrudactSize size;
  final int quantity;

  AddToCartModel({
    required this.prudactId,
    required this.size,
    required this.quantity,
  });

  AddToCartModel copyWith({
    String? prudactId,
    PrudactSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      prudactId: prudactId ?? this.prudactId,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];
