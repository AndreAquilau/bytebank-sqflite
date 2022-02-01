import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {

  final WebClient _webClient = WebClient();

  Future<List<TransactionModel>> findAll() async {
    Response response = await _webClient.client.get(_webClient.baseUrl('transactions')).timeout(
      const Duration(seconds: 5),
    );

    final List<TransactionModel> transactions = [];

    _toTransaction(response, transactions);

    return transactions;
  }

  void _toTransaction(Response response, List<TransactionModel> transactions) {
    final List<dynamic> transactionsJson = jsonDecode(response.body);

    for (Map<String, dynamic> transactionJson in transactionsJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];

      final TransactionModel transactionModel = TransactionModel(
        transactionJson['value'],
        Contact(0, contactJson['name'], contactJson['accountNumber']),
      );

      transactions.add(transactionModel);
    }
  }

  Future<TransactionModel> save(TransactionModel transactionModel) async {
    Map<String, String>? headers = {
      'password': '1000',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> transactionMap = _toMap(transactionModel);

    String transactionJson = jsonEncode(transactionMap);

    final Response response = await _webClient.client
        .post(
      _webClient.baseUrl('transactions'),
      headers: headers,
      body: transactionJson,
      encoding: Encoding.getByName('UTF-8'),
    )
        .timeout(
      const Duration(seconds: 5),
    );

    Map<String, dynamic> responseTransactionJson = jsonDecode(response.body);

    Map<String, dynamic> responseContactJson =
    responseTransactionJson['contact'];

    Contact contact = Contact(
      0,
      responseContactJson['name'],
      responseContactJson['accountNumber'],
    );

    TransactionModel transaction = TransactionModel(
      responseTransactionJson['value'],
      contact,
    );

    return transaction;
  }

  Map<String, dynamic> _toMap(TransactionModel transactionModel) {
    Map<String, dynamic> transactionMap = {
      'value': transactionModel.value,
      'contact': {
        'name': transactionModel.contact.name,
        'accountNumber': transactionModel.contact.accountNumber,
      },
    };
    return transactionMap;
  }
}