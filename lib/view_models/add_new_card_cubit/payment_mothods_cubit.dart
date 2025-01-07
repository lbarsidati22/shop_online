import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/payment_cart_model.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());
  String selectedPaymentId = dummyPaymentCard.first.id;
  void addNewCard(
    String cardNumber,
    String holderName,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLeading());
    final newCart = PaymentCartModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: holderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    //add new card logic
    Future.delayed(Duration(seconds: 2), () {
      dummyPaymentCard.add(newCart);
      emit(AddNewCardLoaded());
    });
  }

  void fetchPaymentMethod() {
    emit(FetchingPaymentMethods());
    Future.delayed(Duration(seconds: 1), () {
      if (dummyPaymentCard.isNotEmpty) {
        emit(
          FetchedPaymentMethods(paymentCarts: dummyPaymentCard),
        );
        final chosenPaymentMethod = dummyPaymentCard.firstWhere(
            (payemntCart) => payemntCart.isChosen == true,
            orElse: () => dummyPaymentCard.first);
        emit(PaymentMethodsChosen(chosenPaymentMethod));
      } else {
        emit(FetchPaymentMethodsError(message: 'No Payment Methods Found !'));
      }
    });
  }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempChosenPaymentMethod = dummyPaymentCard
        .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
    emit(PaymentMethodsChosen(tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLeading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenPaymentMethod = dummyPaymentCard
          .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
      var previousPaymentMethod = dummyPaymentCard.firstWhere(
          (paymentCard) => paymentCard.isChosen == true,
          orElse: () => dummyPaymentCard.first);
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(
        isChosen: true,
      );
      final previousIndex = dummyPaymentCard.indexWhere(
          (paymentCart) => paymentCart.id == previousPaymentMethod.id);
      final chosenIndex = dummyPaymentCard.indexWhere(
          (paymentCart) => paymentCart.id == chosenPaymentMethod.id);

      dummyPaymentCard[previousIndex] = previousPaymentMethod;
      dummyPaymentCard[chosenIndex] = chosenPaymentMethod;
      emit(ConfirmPaymentLoaded());
    });
  }
}
