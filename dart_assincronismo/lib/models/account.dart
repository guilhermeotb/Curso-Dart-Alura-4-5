class Account {
  String id;
  String name;
  String lastName;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });


  factory Account.fromMap(Map<String, dynamic> map) {
    final dynamic rawLastName = map["lastName"] ?? map["lastname"];
    final dynamic rawBalance = map["balance"];

    return Account(
      id: map["id"] as String,
      name: map["name"]as String,
      lastName: rawLastName as String,
      balance: (rawBalance as num).toDouble(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
    };
  }

  @override
  String toString() {
    return 'ID: $id | Nome: $name $lastName | Saldo: R\$ ${balance.toStringAsFixed(2)}';
  }

}