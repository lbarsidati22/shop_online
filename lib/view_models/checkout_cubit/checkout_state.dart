part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLeading extends CheckoutState {}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError({
    required this.message,
  });
}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfPrudacts;

  CheckoutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfPrudacts,
  });
}
