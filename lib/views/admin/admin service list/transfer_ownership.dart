import 'package:flutter/material.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';

class TransferOwnerLst extends StatefulWidget {
  const TransferOwnerLst({super.key});

  @override
  State<TransferOwnerLst> createState() => _TransferOwnerLstState();
}

class _TransferOwnerLstState extends State<TransferOwnerLst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer of Owenrship',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
