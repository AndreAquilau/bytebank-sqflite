import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/widgets/contact_item.dart';

class ListTransferScreen extends StatefulWidget {
  ListTransferScreen({Key? key}) : super();

  @override
  State<ListTransferScreen> createState() => _ListTransferScreenState();
}

class _ListTransferScreenState extends State<ListTransferScreen> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: Future.delayed(const Duration(seconds: 1))
            .then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return const Progress();
              }
            case ConnectionState.done:
              {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('List Contact Empty'),
                  );
                }

                List<Contact> contacts = snapshot.data as List<Contact>;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Contact contact = contacts[index];
                    return ItemContact(
                      contact: contact,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TransactionForm(contact);
                          }),
                        );
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
              }

            default:
              {
                return const Text('Unknown error');
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return FormContact();
            }),
          ).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
