import 'dart:convert';

class Transaction {
  String id;
  String senderAccountId;
  String receiverAccountId;
  DateTime date;
  double amount;
  double taxes;

  Transaction({
    required this.id,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.date,
    required this.amount,
    required this.taxes,
  }); 

  
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id': id,
      'senderAccountId':senderAccountId,
      'receiverAccountId': receiverAccountId,
      'date' : date.millisecondsSinceEpoch,
      'amount': amount,
      'taxes' : taxes,
    };
  }
  
  
  factory Transaction.fromMap(Map<String, dynamic> map) {
    final dynamic rawDate = map["date"];
    final dynamic rawAmount = map["amount"];
    final dynamic rawTaxes = map["taxes"];

    final DateTime parsedDate =
        rawDate is int || rawDate is num
            ? DateTime.fromMillisecondsSinceEpoch((rawDate as num).toInt())
            : DateTime.parse(rawDate as String);

    return Transaction(
      id: map["id"].toString(),
      senderAccountId: map["senderAccountId"].toString(),
      receiverAccountId: map["receiverAccountId"].toString(),
      date: parsedDate,
      amount: (rawAmount as num).toDouble(),
      taxes: (rawTaxes as num).toDouble(),
    );
  }

Transaction copyWith({
  String? id,
  String? senderAccountId,
  String? receiverAccountId,
  DateTime? date,
  double? amount,
  double? taxes,
}) {
  return Transaction(
    id: id ?? this.id,
    senderAccountId: senderAccountId ?? this.senderAccountId,
    receiverAccountId: receiverAccountId ?? this.receiverAccountId,
    date: date ?? this.date,
    amount: amount ?? this.amount,
    taxes: taxes ?? this.taxes,

  );
}

String toJson() => json.encode(toMap());

factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

@override
String toString() {
  return 'Transaction(id: $id, senderAccountId: $senderAccountId, receiverAccountId: $receiverAccountId, date: $date, amount: $amount, taxes: $taxes)';
}

@override
bool operator ==(covariant Transaction other) {
  if (identical(this, other)) return true;
  return other.id == id &&
    other.senderAccountId == senderAccountId &&
    other.receiverAccountId == receiverAccountId &&
    other.date == date &&
    other.amount == amount &&
    other.taxes == taxes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderAccountId.hashCode ^
        receiverAccountId.hashCode ^
        date.hashCode ^
        amount.hashCode ^
        taxes.hashCode;
  }
}