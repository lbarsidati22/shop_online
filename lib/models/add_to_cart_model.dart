
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

  AddToCartModel copyWith({
    String? id,
    PrudactItemModel? prudact,
    PrudactSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      prudact: prudact ?? this.prudact,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prudact': prudact.toMap(),
      'size': size.name,
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] ?? '',
      prudact: PrudactItemModel.fromMap(map['prudact']),
      size: PrudactSize.formString(map['size']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}

List<AddToCartModel> dummyCart = [];
