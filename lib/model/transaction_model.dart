class TransactionModel {
  int? id;
  String type;
  String transactionNumber;
  double amount;
  String date;
  double commission;
  double total;
  String operationType;
  String status;

  TransactionModel(
      {this.id,
      required this.type,
      required this.transactionNumber,
      required this.amount,
      required this.date,
      required this.commission,
      required this.total,
      required this.operationType,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'transactionNumber': transactionNumber,
      'amount': amount,
      'date': date,
      'commission': commission,
      'total': total,
      'operationType': operationType,
      'status': status,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      transactionNumber: map['transactionNumber'],
      amount: map['amount'],
      date: map['date'],
      commission: map['commission'],
      total: map['total'],
      operationType: map['operationType'],
      status: map['status'],
    );
  }
}
