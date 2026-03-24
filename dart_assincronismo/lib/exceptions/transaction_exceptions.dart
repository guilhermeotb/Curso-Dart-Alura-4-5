import 'package:dart_assincronismo/models/account.dart';

class SenderNotExistException implements Exception{
  final String message;
  SenderNotExistException({this.message = "Conta remetente não existe."});
}
class ReceiverNotExistException implements Exception{
  final String message;
  ReceiverNotExistException({this.message = "Conta destinatária não existe."});   
}
class InsufficientBalanceException implements Exception{
  String message; //Mensagem amigavel
  Account cause; // Objeto causador da exceção
  double amount; // Informações específicas
  double taxes; // Informações específicas

  InsufficientBalanceException({
    this.message = "Saldo insuficiente para a transação.",
    required this.cause,
    required this.amount,
    required this.taxes,
  });
}