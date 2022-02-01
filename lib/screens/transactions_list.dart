import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/widgets/centered_message.dart';
import 'package:bytebank/widgets/transaction_item.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {

  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: Future.delayed(
          const Duration(seconds: 2),
          () => _webClient.findAll(),
        ),
        initialData: const [],
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Progress();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<TransactionModel> transactions =
                    snapshot.data as List<TransactionModel>;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final TransactionModel transaction = transactions[index];
                      return ItemTransaction(transaction: transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage(
                'Not found transaction',
                icon: Icons.warning,
              );
              break;
            default:
              return CenteredMessage('Error Unknow');
              break;
          }
        },
      ),
    );
  }
}
