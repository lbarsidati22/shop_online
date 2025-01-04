class PaymentCartModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;

  PaymentCartModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });
}

List<PaymentCartModel> dummyPaymentCard = [
  PaymentCartModel(
    id: '1',
    cardNumber: '1234 5678 9012 3456',
    cardHolderName: 'Lbar Sidati',
    expiryDate: '12/23',
    cvv: '123',
  ),
  PaymentCartModel(
    id: '2',
    cardNumber: '1234 5678 9012 3466',
    cardHolderName: 'John Doe',
    expiryDate: '12/23',
    cvv: '123',
  ),
  PaymentCartModel(
    id: '3',
    cardNumber: '1234 5678 9012 3477',
    cardHolderName: 'Tim Smith',
    expiryDate: '12/23',
    cvv: '123',
  ),
];
