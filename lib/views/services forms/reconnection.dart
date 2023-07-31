// ignore_for_file: use_build_context_synchronously, avoid_web_libraries_in_flutter, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:html' as html;

class ReconnectionForm extends StatefulWidget {
  const ReconnectionForm({super.key});

  @override
  ReconnectionFormState createState() => ReconnectionFormState();
}

class ReconnectionFormState extends State<ReconnectionForm> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  void submitForm() async {
    var url = Uri.parse('https://capstone.smccnasipit.edu.ph/ocsms-nwd/user-services/reconnection.php');

    var response = await http.post(url, body: {
      'accountName': accountNameController.text,
      'accountNumber': accountNumberController.text,
      'landmark': landmarkController.text,
      'contact': contactController.text,
    });

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        QuickAlert.show(
          context: context,
          onConfirmBtnTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const MainView();
                },
              ),
            );
          },
          type: QuickAlertType.success,
          text: 'Request Submitted Successfully',
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Request Submission Failed',
        );
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Error: ${response.statusCode}',
      );
    }
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    landmarkController.dispose();
    contactController.dispose();
    accountNameController.dispose();
    super.dispose();
  }

  void _openWebsiteURL(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isNarrowScreen = screenWidth <= 800;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          _openWebsiteURL('https://www.facebook.com/nwdcustservice/');
        },
        child: const Image(
          image: AssetImage('assets/images/messenger.png'),
        ),
      ),
      appBar: CustomAppBar(isNarrowScreen: isNarrowScreen),
      drawer: isNarrowScreen || screenWidth == 800
          ? CustomDrawer(onMenuSelected: (value) {
              if (RoutesWidget.routes.containsKey(value.route)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: RoutesWidget.routes[value.route]!,
                  ),
                );
              } else if (value.route == '/new-water-connection') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ConnectionDialog();
                    });
              }
            })
          : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text(
                    'Water Reconnection Form',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 500,
                  child: TextField(
                    autofocus: true,
                    controller: accountNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.account_circle_outlined),
                      labelText: 'Account Name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 500,
                  child: TextField(
                    controller: accountNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.numbers),
                      labelText: 'Account Number',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 500,
                  child: TextField(
                    controller: landmarkController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.location_on),
                      labelText: 'Landmark',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 500,
                  child: TextField(
                    controller: contactController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.location_on),
                      labelText: 'Contact Number',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 500,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
                    ),
                    onPressed: submitForm,
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
                const Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text:
                            'Note: Reconnection of accounts/line requires the payment of the \nfull ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'BALANCE',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' plus, fontSize: 20,',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' reconnection fee of. ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Php 100.00',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
