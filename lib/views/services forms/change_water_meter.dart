// ignore_for_file: avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:nwd/views/services%20forms/main.view.dart';

import 'package:quickalert/quickalert.dart';

import 'transfer/transfer_ownership.dart';

class ChangeWaterMeter extends StatefulWidget {
  const ChangeWaterMeter({super.key});

  @override
  State<ChangeWaterMeter> createState() => _ChangeWaterMeterState();
}

class _ChangeWaterMeterState extends State<ChangeWaterMeter> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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

  @override
  void dispose() {
    accountNumberController.dispose();
    landmarkController.dispose();
    contactController.dispose();
    accountNameController.dispose();
    addressController.dispose();
    landmarkController.dispose();
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
                  const Text(
                    'Change Water Meter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: accountNameController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.person),
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
                      controller: addressController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.location_on),
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
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.numbers),
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
                      onPressed: () {
                        submitForm('change_meter');
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
