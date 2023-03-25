class FlutterWavePaymentModel {
  FlutterWavePaymentModel({
    required this.status,
    required this.customer,
    required this.transactionId,
    required this.txRef,
    required this.flwRef,
    required this.currency,
    required this.amount,
    required this.chargedAmount,
    required this.chargeResponseCode,
    required this.chargeResponseMessage,
    required this.createdAt,
  });

  final String status;
  final Customer customer;
  final int transactionId;
  final String txRef;
  final String flwRef;
  final String currency;
  final int amount;
  final int chargedAmount;
  final String chargeResponseCode;
  final String chargeResponseMessage;
  final DateTime createdAt;

  factory FlutterWavePaymentModel.fromMap(Map<String, dynamic> json) {
    return FlutterWavePaymentModel(
      status: json["status"],
      customer: Customer.fromMap(json["customer"]),
      transactionId: json["transaction_id"],
      txRef: json["tx_ref"],
      flwRef: json["flw_ref"],
      currency: json["currency"],
      amount: json["amount"],
      chargedAmount: json["charged_amount"],
      chargeResponseCode: json["charge_response_code"],
      chargeResponseMessage: json["charge_response_message"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "status": status,
      "customer": customer.toMap(),
      "transaction_id": transactionId,
      "tx_ref": txRef,
      "flw_ref": flwRef,
      "currency": currency,
      "amount": amount,
      "charged_amount": chargedAmount,
      "charge_response_code": chargeResponseCode,
      "charge_response_message": chargeResponseMessage,
      "created_at": createdAt.toIso8601String(),
    };
  }
}

class Customer {
  Customer({required this.name, required this.email});

  final String name;
  final String email;

  factory Customer.fromMap(Map<String, dynamic> json) {
    return Customer(name: json["name"], email: json["email"]);
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email};
  }
}
