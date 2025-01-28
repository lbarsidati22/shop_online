import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/payment_cart_model.dart';
import 'package:shop_online/services/auth_services.dart';
import 'package:shop_online/services/checkout_services.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());
  String? selectedPaymentId;
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthSrevicesImpl();
  Future<void> addNewCard(
    String cardNumber,
    String holderName,
    String expiryDate,
    String cvv,
  ) async {
    emit(AddNewCardLeading());
    try {
      final newCart = PaymentCartModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: holderName,
        expiryDate: expiryDate,
        cvv: cvv,
      );
      //add new card logic
      final currentUser = authServices.currentUser();
      await checkoutServices.setCart(currentUser!.uid, newCart);
      emit(AddNewCardLoaded());
    } catch (e) {
      emit(AddNewCardError(message: e.toString()));
    }
  }

  Future<void> fetchPaymentMethod() async {
    emit(FetchingPaymentMethods());
    try {
      final currentUser = authServices.currentUser();
      final paymentCarts =
          await checkoutServices.fetchPaymentMethods(currentUser!.uid);
      emit(FetchedPaymentMethods(paymentCarts: paymentCarts));
      if (paymentCarts.isNotEmpty) {
        final chosenPaymentMethod = paymentCarts.firstWhere(
            (element) => element.isChosen,
            orElse: () => paymentCarts.first);

        selectedPaymentId = chosenPaymentMethod.id;
        emit(PaymentMethodsChosen(chosenPaymentMethod));
      }
    } catch (e) {
      emit(AddNewCardError(message: e.toString()));
    }
  }

  Future<void> changePaymentMethod(String id) async {
    selectedPaymentId = id;
    try {
      final currentUser = authServices.currentUser();
      final tempChosenPaymentMethod = await checkoutServices
          .fetchSinglePaymentMethods(currentUser!.uid, selectedPaymentId!);
      emit(PaymentMethodsChosen(tempChosenPaymentMethod));
    } catch (e) {
      emit(FetchPaymentMethodsError(message: e.toString()));
    }
  }

  Future<void> confirmPaymentMethod() async {
    emit(ConfirmPaymentLeading());
    try {
      final currentUser = authServices.currentUser();
      final previousChosenPaymentMethod =
          (await checkoutServices.fetchPaymentMethods(currentUser!.uid, true))
              .first
              .copyWith(isChosen: false);
      var chosenPaymentMethod = await checkoutServices
          .fetchSinglePaymentMethods(currentUser.uid, selectedPaymentId!);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
      await checkoutServices.setCart(
          currentUser.uid, previousChosenPaymentMethod);
      await checkoutServices.setCart(currentUser.uid, chosenPaymentMethod);
    } catch (e) {
      emit(ConfirmPaymentError(message: e.toString()));
    }
  }
}
