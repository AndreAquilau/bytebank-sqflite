import 'package:bytebank/models/contact.dart';

class TransactionModel {
  final double value;
  final Contact contact;

  TransactionModel(
      this.value,
      this.contact,
      );

  TransactionModel.fromJson(Map<String, dynamic> json) :
      value = json['value'],
      contact = Contact.fromJson(json['contact']);

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

}
