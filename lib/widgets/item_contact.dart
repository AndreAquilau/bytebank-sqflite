import 'package:flutter/material.dart';
import 'package:bytebank/models/Contact.dart';

class ItemContact extends StatefulWidget {
  final Contact contact;

  const ItemContact({Key? key, required this.contact}) : super(key: key);

  @override
  State<ItemContact> createState() => _ItemContactState();
}

class _ItemContactState extends State<ItemContact> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.contact.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
