import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/payment_cart_model.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

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
      } else {
        emit(FetchPaymentMethodsError(message: 'No Payment Methods Found !'));
      }
    });
  }
}
