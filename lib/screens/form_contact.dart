import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:flutter/material.dart';

class FormContact extends StatelessWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAccount = TextEditingController();
  final ContactDao _dao = ContactDao();

  FormContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Contact'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  hintText: 'André',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerAccount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Account'),
                  hintText: '1234',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(double.maxFinite, 45),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  final String name = _controllerName.text;
                  final int? accountNumber =
                      int.tryParse(_controllerAccount.text);

                  if (name.trim() == '' || accountNumber == null) return;

                  Contact contact = Contact(0, name, accountNumber);

                  _dao.save(contact).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
