// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/New%20Water%20Connection/main%20applicant/basic_details_main_applicant.dart';
import 'package:nwd/views/New%20Water%20Connection/main%20applicant/photos_main_applicant.dart';
import 'package:nwd/views/New%20Water%20Connection/views/video.dart';
import 'package:quickalert/quickalert.dart';

class TermsAndConditionsMainApplicant extends StatefulWidget {
  const TermsAndConditionsMainApplicant({super.key});

  @override
  State<TermsAndConditionsMainApplicant> createState() =>
      _TermsAndConditionsMainApplicantState();
}

class _TermsAndConditionsMainApplicantState
    extends State<TermsAndConditionsMainApplicant> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _videoCodeController = TextEditingController();

  Future<void> verifyCode(String code) async {
    var url = Uri.parse(
        'http://localhost/nwd/main-applicant/requirements_code_main_applicant.php');
    var response = await http.post(url, body: {'code': code});

    if (response.body == 'success') {
      var userDataResponse = await http.post(
        Uri.parse(
            'http://localhost/nwd/main-applicant/user_data_main_applicant.php'),
        body: {'code': code},
      );
      var userData = jsonDecode(userDataResponse.body);

      requirementsMainApplicant(userData);
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Code Does not Exist',
      );
    }
  }

  Future<void> verifyOrientation(String code) async {
    var url =
        Uri.parse('http://localhost/nwd/user-services/orientation_code.php');
    var response = await http.post(url, body: {'code': code});

    if (response.body == 'success') {
      videoMainApplicant(code: code);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Code Not Found'),
            content:
                const Text('The entered code does not exist in the database.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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
              }
            })
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 20,
            ),
            const Text(
              'New Water Connectection Requirements',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              '(Main Applicant)',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Text(
                  '1. Evaluation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Enter Basic details for Evaluation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Receive SMS code \n(Use code to proceed to step 2)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sketch Map & List of \nMaterials from evaluation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '2. Secure Requirements',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Already Secured \nStep 2 Requirements?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                
                children: [
                  ElevatedButton(
            
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      QuickAlert.show(
                        context: context,
                        confirmBtnText: 'Submit',
                        type: QuickAlertType.info,
                        title: 'Verification',
                        widget: TextField(
                          controller: _codeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.phone_android),
                              hintText: 'Enter your 6 digit code to proceed'),
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
                              text: 'Invalid Code',
                            );
                          }
                        },
                      );
                    },
                    child: const Text(
                      'Enter code here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Water Permit - MPDC Office \n(requirement: Sketch Map \n& List of \nMaterials from evaluation)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Waiver/Consent from Lot Owner',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Lot Title or Tax Declaration \nor Deed of sale',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Photocopy of 1 Valid ID',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Barangay Certificate of Residency',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Receive SMS for update \n(For step 3)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '3. Video Orientation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Already done with step 2?',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.phone_android),
                              hintText: 'Enter your 6 digit code to proceed'),
                        ),
                        onConfirmBtnTap: () {
                          String code = _videoCodeController.text.trim();
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
                    child: const Text(
                      'Enter code here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Watch Orientation Video',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Answer Orientation \nBased Questions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Take a screenshot of Certificate',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Receive SMS for update \n(approved/declined)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '4. PAYMENT/SIGNING \nOF CONTRACT \nFOR NEW CONNECTION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Present your Certificate \n(Orientation Video Certificate)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  '(Php 3,000)',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Installation Fee = 1,500',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Water Meter = 1,500',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  '+ PLUS MATERIALS',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: const Text('Cancel')),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        basicdetailsMainApplicant();
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  void basicdetailsMainApplicant() {
    showDialog(
        context: context,
        builder: (builder) {
          return const BasicDetailsMainApplicant();
        });
  }

  void requirementsMainApplicant(Map<String, dynamic> userData) {
    showDialog(
        context: context,
        builder: (builder) {
          return RequirementsMainApplicant(userData: userData);
        });
  }

  void videoMainApplicant({required String code}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return Video(code: code);
        });
  }
}
