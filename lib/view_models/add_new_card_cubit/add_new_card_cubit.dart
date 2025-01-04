import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/models/add_to_cart_model.dart';
import 'package:shop_online/models/payment_cart_model.dart';

part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

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
}
