//dart pub get
//dart run bin/main.dart

import 'package:dart_assincronismo/screens/account_screen.dart';

Future<void> main() async {
	final AccountScreen accountScreen = AccountScreen();
	accountScreen.initializeStream();
	await accountScreen.runChatBot();
}