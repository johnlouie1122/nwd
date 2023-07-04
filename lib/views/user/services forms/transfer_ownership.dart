import 'package:flutter/material.dart';
import 'package:nwd/views/user/homepage/homepage.dart';

class TransferOfOwnership extends StatefulWidget {
  const TransferOfOwnership({super.key});

  @override
  State<TransferOfOwnership> createState() => _TransferOfOwnershipState();
}

class _TransferOfOwnershipState extends State<TransferOfOwnership> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: AlertDialog(
          scrollable: true,
          title: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Text('Transfer Of Ownership Form'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
