part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLeading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartsItem;

  const CartLoaded(
    this.cartsItem,
  );
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}

final class QuantityCounterLoaded extends CartState {
  final int value;

  QuantityCounterLoaded({required this.value});
}
