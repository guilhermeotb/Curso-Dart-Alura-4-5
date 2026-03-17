//dart pub get
//dart run bin/main.dart

import 'package:dart_assincronismo/screens/account_screen.dart';
import 'package:dart_assincronismo/services/transaction_service.dart';

void main() {
    TransactionService().makeTransaction(
    idSender: "ID001",
    idReceiver: "ID002",
    amount: 5,
  );
  // AccountScreen accountScreen = AccountScreen();
  // accountScreen.initializeStream();
  //accountScreen.runChatBot();
}