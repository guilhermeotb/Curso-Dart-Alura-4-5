import 'dart:async';
import 'dart:convert';

import 'package:dart_assincronismo/api_key.dart';
import 'package:dart_assincronismo/models/account.dart';
import 'package:http/http.dart';

class AccountService {
  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = "https://api.github.com/gists/b5e5988083befbf76bfc7e34c6f518d1";

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(url));

    _streamController.add("${DateTime.now()} | Requisição de leitura.");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["accounts.json"]["content"],
    );
    List<Account> listAccounts = [];
    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccounts.add(account);
    }

    return listAccounts;
  }

  addAccount(Account account) async{
    List<Account> listAccounts = await getAll();
    listAccounts.add(account);
    List<Map<String, dynamic>> listContent = [];

    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = JsonEncoder.withIndent('  ').convert(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "account.json",
    "public" : true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} | Requisição de adição bem sucedida (${account.name}).",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} | Requisição falhou. (${account.name}).",
      );
    }
  }

  deleteAccount(String accountId) async {
    List<Account> listAccounts = await getAll();
    listAccounts.removeWhere((account) => account.id == accountId);

    List<Map<String, dynamic>> listContent =
        listAccounts.map((account) => account.toMap()).toList();
    String content = JsonEncoder.withIndent('  ').convert(listContent);

    Response response = await patch(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} | Requisição de remoção bem sucedida ($accountId).",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} | Requisição falhou. ($accountId).",
      );
    }
  }
}