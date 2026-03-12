import 'dart:async';
import 'dart:io';

import 'package:dart_assincronismo/services/account_service.dart';
import 'package:uuid/uuid.dart';

import '../models/account.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((infoString) {
      print(infoString);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - 👀 Ver todas sua contas.");
      print("2 - ➕ Adicionar nova conta.");
      print("3 - 🗑️ Excluir conta.");
      print("4 - Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addNewAccount();
              break;
            }
          case "3":
            {
              await _deleteAccountChat();
              break;
            }
          case "4":
            {
              isRunning = false;
              print("Te vejo na próxima. 👋");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente.");
            }
        }
      }
    }
  }

  Future<void> _getAllAccounts() async {

    try{
    List<Account> listAccounts = await _accountService.getAll();
    for (Account account in listAccounts) {
      print(account);
    }
    } on Exception {
      print("Ocorreu um erro ao buscar as contas. Tente novamente mais tarde.");
    }
  }

  Future<void> _addNewAccount() async {
    print("Qual o nome da pessoa?");
    String? name = stdin.readLineSync()?.trim();
    if (name == null || name.isEmpty) {
      print("Nome inválido.");
      return;
    }

    print("Qual o sobrenome da pessoa?");
    String? lastName = stdin.readLineSync()?.trim();
    if (lastName == null || lastName.isEmpty) {
      print("Sobrenome inválido.");
      return;
    }

    print("Qual o saldo da conta?");
    String? balanceInput = stdin.readLineSync()?.trim();
    double? balance = balanceInput == null
        ? null
        : double.tryParse(balanceInput);
    if (balance == null) {
      print("Saldo inválido.");
      return;
    }

    Account account = Account(
      id: Uuid().v1(),
      name: name,
      lastName: lastName,
      balance: balance,
    );

    await _accountService.addAccount(account);
    print("Conta adicionada com sucesso.");
  }

  Future<void> _deleteAccountChat() async {
    print("Qual o ID da conta que deseja excluir?");
    String? accountId = stdin.readLineSync()?.trim();
    if (accountId == null || accountId.isEmpty) {
      print("ID inválido.");
      return;
    }
    await _accountService.deleteAccount(accountId);
    print("Conta excluída com sucesso.");
  }
}