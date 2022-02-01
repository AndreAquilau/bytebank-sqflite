import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FeatureItem(
                      name: 'Transfer',
                      iconFeature: Icons.monetization_on,
                      onTap: () => _showContactList(context),
                    ),
                    _FeatureItem(
                      name: 'Transection feed',
                      iconFeature: Icons.description,
                      onTap: () => _showTransationList(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showContactList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ListTransferScreen();
      }),
    );
  }
  void _showTransationList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TransactionsList();
      }),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData iconFeature;
  final void Function() onTap;

  _FeatureItem({
    Key? key,
    required this.name,
    required this.iconFeature,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 160,
      height: 115,
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconFeature,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
