import 'package:flutter/material.dart';
import 'package:nwd/views/user/homepage/homepage.dart';

class ReconnectionForm extends StatefulWidget {
 
  const ReconnectionForm({super.key});

  @override
  State<ReconnectionForm> createState() => _ReconnectionFormState();
}

class _ReconnectionFormState extends State<ReconnectionForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const CustomDrawer(
        ),
        body: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
          child: AlertDialog(
            title: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  const Text('Water Reconnection Form', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.numbers),
                        labelText: 'Account Number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.account_circle_outlined),
                        labelText: 'Account Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.location_on),
                        labelText: 'Landmark',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Sucess!'),
                              content:
                                  const Text('Request Submitted Successfully'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text.rich(
                    TextSpan(
                      text:
                          'Note: Reconnection of accounts/line requires the payment of the \nfull ',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'BALANCE',
                          style: TextStyle(color: Colors.red),
                          ),
                        TextSpan(text: ' plus'),
                        TextSpan(text: ' reconnection fee of. '),
                        TextSpan(
                          text: 'Php 100.00',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
