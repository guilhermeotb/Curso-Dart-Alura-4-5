//dart pub get
//dart run bin/main.dart

import 'package:dart_assincronismo/screens/account_screen.dart';
import 'package:dart_assincronismo/services/transaction_service.dart';

Future<void> main() async {
  try {
    print('Iniciando transferencia...');
    await TransactionService().makeTransaction(
      idSender: "ID888",
      idReceiver: "ID002",
      amount: 5,
    );
    print('Transferencia finalizada.');
  } catch (e, s) {
    print('Erro ao executar transferencia: $e');
    print(s);
  }

  // AccountScreen accountScreen = AccountScreen();
  // accountScreen.initializeStream();
  //accountScreen.runChatBot();
}