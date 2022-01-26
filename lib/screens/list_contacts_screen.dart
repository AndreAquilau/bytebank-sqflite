import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/screens/form_contact.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/widgets/item_contact.dart';

class ListContactsScreen extends StatefulWidget {
  ListContactsScreen({Key? key}) : super();

  @override
  State<ListContactsScreen> createState() => _ListContactsScreenState();
}

class _ListContactsScreenState extends State<ListContactsScreen> {
  final ContactDao _dao = ContactDao();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                      const Text('Loading'),
                    ],
                  ),
                );
              }
            case ConnectionState.done:
              {
                List<dynamic> contacts = snapshot.data as List<dynamic>;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Contact contact = contacts[index];
                    return ItemContact(contact: contact);
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
