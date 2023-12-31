// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:html' as html;

import 'transfer/transfer_ownership.dart';

class Disconnection extends StatefulWidget {
  const Disconnection({Key? key}) : super(key: key);

  @override
  State<Disconnection> createState() => _DisconnectionState();
}

class _DisconnectionState extends State<Disconnection> {
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final contactController = TextEditingController();

  void submitForm(String table) async {
    var url = Uri.parse('http://localhost/nwd/user-services/add.php');

    var response = await http.post(url, body: {
      'accountName': accountNameController.text,
      'accountNumber': accountNumberController.text,
      'address': addressController.text,
      'landmark': landmarkController.text,
      'contact': contactController.text,
      'table': table,
    });

    if (response.statusCode == 200) {
      if (response.body == 'success') {
        QuickAlert.show(
          context: context,
          onConfirmBtnTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return const MainView();
            }), (route) => false);
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
              } else if (value.route == '/transfer-ownership') {
                showDialog(context: context, builder: (BuildContext context) {
                  return const TransferDialog();
                });
              }
            })
          : null,
      body: SingleChildScrollView(
        child: Container(
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
                  SizedBox(
                    height: 15,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Text(
                    'Disconnection Form',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: accountNameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
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
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        labelText: 'Account Number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.location_pin),
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: landmarkController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.location_pin),
                        border: OutlineInputBorder(),
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
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        labelText: 'Contact Number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: 500,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        submitForm('disconnection');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'SUBMIT REQUEST',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
