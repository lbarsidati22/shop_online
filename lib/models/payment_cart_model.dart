class PaymentCartModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentCartModel({
    this.isChosen = false,
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });

  PaymentCartModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCartModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'isChosen': isChosen,
    };
  }

  factory PaymentCartModel.fromMap(Map<String, dynamic> map) {
    return PaymentCartModel(
      id: map['id'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cardHolderName: map['cardHolderName'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      cvv: map['cvv'] ?? '',
      isChosen: map['isChosen'] ?? false,
    );
  }
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
