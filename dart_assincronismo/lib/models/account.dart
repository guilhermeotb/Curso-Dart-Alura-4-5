class Account {
  String id;
  String name;
  String lastName;
  double balance;
  String? accountType;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
    required this.accountType,
  });


  factory Account.fromMap(Map<String, dynamic> map) {
    final dynamic rawLastName = map["lastName"] ?? map["lastname"];
    final dynamic rawBalance = map["balance"];

    return Account(
      id: map["id"] as String,
      name: map["name"]as String,
      lastName: rawLastName as String,
      balance: (rawBalance as num).toDouble(),
      accountType:(map["accountType"] != null) ? map["accountType"] as String : null,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
      "accountType": accountType,
    };
  }

Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
    String? accountType,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
    );
  }


  @override
  String toString() {
    return 'ID: $id | Nome: $name $lastName | Saldo: R\$ ${balance.toStringAsFixed(2)}';
  }

}