part of 'payment_mothods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class AddNewCardLeading extends PaymentMethodsState {}

final class AddNewCardLoaded extends PaymentMethodsState {
  //final List<PaymentCartModel> addNewCards;
}

final class AddNewCardError extends PaymentMethodsState {
  final String message;

  AddNewCardError({required this.message});
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCartModel> paymentCarts;

  FetchedPaymentMethods({
    required this.paymentCarts,
  });
}

final class FetchPaymentMethodsError extends PaymentMethodsState {
  final String message;

  FetchPaymentMethodsError({required this.message});
}
