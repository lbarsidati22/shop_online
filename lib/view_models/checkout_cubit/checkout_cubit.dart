import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/payment_cart_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItems() {
    emit(CheckoutLeading());
    final cartItems = dummyCart;
    final subtotla = cartItems.fold(
      0.0,
      (previuseValue, element) =>
          previuseValue + (element.prudact.price * element.quantity),
    );
    final numOfPrudacts = cartItems.fold(
      0,
      (previuseValue, element) => previuseValue + element.quantity,
    );
    final PaymentCartModel? chosenPaymentCards = dummyPaymentCard.firstWhere(
        (element) => element.isChosen == true,
        orElse: () => dummyPaymentCard.first);
    emit(CheckoutLoaded(
      chosenPaymentCards: chosenPaymentCards,
      cartItems: cartItems,
      totalAmount: subtotla + 10,
      numOfPrudacts: numOfPrudacts,
    ));
  }
}
