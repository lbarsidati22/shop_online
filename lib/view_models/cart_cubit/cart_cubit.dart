import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;
  void getCartsItems() {
    emit(CartLeading());

    emit(CartLoaded(_subtotal, dummyCart));
  }

  void incrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere(
      (item) => item.prudact.id == prudactId,
    );
    dummyCart[index] = dummyCart[index].copyWith(
      quantity: quantity,
    );

    emit(QuantityCounterLoaded(value: quantity, prudactId: prudactId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  void decrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
    }

    final index = dummyCart.indexWhere(
      (item) => item.prudact.id == prudactId,
    );
    dummyCart[index] = dummyCart[index].copyWith(
      quantity: quantity,
    );

    emit(QuantityCounterLoaded(value: quantity, prudactId: prudactId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  double get _subtotal => dummyCart.fold<double>(
      0,
      (previuseValue, item) =>
          previuseValue + (item.prudact.price * item.quantity));
}
