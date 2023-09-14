// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/footer.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/services%20forms/New%20Water%20Connection/representative/basic_details_rep.dart';
import 'package:nwd/views/services%20forms/New%20Water%20Connection/representative/photos_representative.dart';
import 'package:nwd/views/services%20forms/New%20Water%20Connection/views/video.dart';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';

import '../../transfer/transfer_ownership.dart';

class TermsAndConditionsRepresentative extends StatefulWidget {
  const TermsAndConditionsRepresentative({super.key});

  @override
  TermsAndConditionsRepresentativeState createState() =>
      TermsAndConditionsRepresentativeState();
}

class TermsAndConditionsRepresentativeState
    extends State<TermsAndConditionsRepresentative> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _videoCodeController = TextEditingController();

  Future<void> verifyCode(String code) async {
    var url = Uri.parse(
        'http://localhost/nwd/representative/requirements_code_representative.php');
    var response = await http.post(url, body: {'code': code});

    if (response.body == 'success') {
      var userDataResponse = await http.post(
        Uri.parse(
            'http://localhost/nwd/representative/user_data_representative.php'),
        body: {'code': code},
      );
      var userData = jsonDecode(userDataResponse.body);

      requirementsRepresentative(userData);
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Code does not Exist',
      );
    }
  }

  Future<void> verifyOrientation(String code) async {
    var url =
        Uri.parse('http://localhost/nwd/user-services/orientation_code.php');
    var response = await http.post(url, body: {'code': code});

    if (response.body == 'success') {
      videoRepresentative(code: code);
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Invalid Code',
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _videoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool isNarrowScreen = screenWidth <= 800;
        return Scaffold(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'New Water Connection Steps \n(Representative)',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        '1. E V A L U A T I O N',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '• Submit basic details',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Receive SMS code\n(Use code to proceed to step 2)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Sketch map & list of \nmaterials from evaluation',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                                child: Image(
                                  image: AssetImage('assets/images/evaluation.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      basicDetailsRepresentative();
                                    },
                                    child: const Text('S T A R T'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'R E Q U I R E M E N T S ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '• Water Permit - MPDC office\n(Requirement: Sketch map & list of materials from evaluation)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Waiver/Consent from lot owner',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Lot title/Tax decleration/Deed of sale',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• 1 copy of valid ID',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Barangay certificate of residency',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Authorization Letter (Signed by the main applicant)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• 1 copy of valid ID of representative',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Receive SMS for step 3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                                child: Image(
                                  image:
                                      AssetImage('assets/images/requirements.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    QuickAlert.show(
                                      context: context,
                                      confirmBtnText: 'Submit',
                                      type: QuickAlertType.info,
                                      title: 'Verification. . . ',
                                      widget: TextField(
                                        controller: _codeController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.phone_android),
                                            hintText:
                                                'Enter your 6 digit code to proceed'),
                                      ),
                                      onConfirmBtnTap: () {
                                        String code = _codeController.text.trim();
                                        if (code.isNotEmpty && code.length == 6) {
                                          verifyCode(code);
                                        } else {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text: 'Invalid code',
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: const Text('Requirements secured?'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'O R I E N T A T I O N',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '• Watch orientation video',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Answer orientation based questions',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Take a screenshot of certificate',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Recieve SMS update\n(Application result)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 150,
                                child: Image(
                                  image:
                                      AssetImage('assets/images/orientation.png'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    QuickAlert.show(
                                      context: context,
                                      confirmBtnText: 'Submit',
                                      type: QuickAlertType.info,
                                      title: 'Verification',
                                      widget: TextField(
                                        controller: _videoCodeController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.phone_android),
                                            hintText:
                                                'Enter your 6 digit code to proceed'),
                                      ),
                                      onConfirmBtnTap: () {
                                        String code =
                                            _videoCodeController.text.trim();
                                        if (code.isNotEmpty && code.length == 6) {
                                          verifyOrientation(code);
                                        } else {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text: 'Invalid Code',
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: const Text('Orientation code secured?'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'P A Y M E N T',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '• Present certificate image',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Installation Fee = 1,500',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '• Water Meter  = 1,500',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      '+ Materials',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: Image(
                                  image: AssetImage('assets/images/payment.png'),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  void basicDetailsRepresentative() {
    showDialog(
        context: context,
        builder: (builder) {
          return const BasicDetailsRepresentative();
        });
  }

  void requirementsRepresentative(Map<String, dynamic> userData) {
    showDialog(
        context: context,
        builder: (builder) {
          return RequirementsRepresentative(userData: userData);
        });
  }

  void videoRepresentative({required String code}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return Video(code: code);
        });
  }
}
