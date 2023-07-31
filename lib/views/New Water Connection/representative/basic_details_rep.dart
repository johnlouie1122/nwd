// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class BasicDetailsRepresentative extends StatefulWidget {
  const BasicDetailsRepresentative({super.key});

  @override
  State<BasicDetailsRepresentative> createState() =>
      _BasicDetailsRepresentativeState();
}

class _BasicDetailsRepresentativeState
    extends State<BasicDetailsRepresentative> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _nearestCustomerController =
      TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    _landmarkController.dispose();
    _nearestCustomerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'ENTER BASIC DETAILS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                textField(
                  const Icon(Icons.person_rounded),
                  'FULL NAME',
                  MediaQuery.of(context).size.width / 2,
                  _fullNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                textField(
                  const Icon(Icons.location_on_rounded),
                  'ADDRESS',
                  MediaQuery.of(context).size.width / 2,
                  _addressController,
                ),
                const SizedBox(height: 10),
                textField(
                  const Icon(Icons.numbers_rounded),
                  'CONTACT NUMBER',
                  MediaQuery.of(context).size.width / 2,
                  _contactNumberController,
                ),
                const SizedBox(height: 10),
                textField(
                  const Icon(Icons.pin_drop),
                  'Landmark',
                  MediaQuery.of(context).size.width / 2,
                  _landmarkController,
                ),
                const SizedBox(height: 10),
                textField(
                  const Icon(Icons.near_me),
                  'Nearest Existing NWD customer (Neighbor/s Name)',
                  MediaQuery.of(context).size.width / 2,
                  _nearestCustomerController,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      if (_validateFields()) {
                        submitDetails();
                        QuickAlert.show(
                          context: context,
                          onConfirmBtnTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const MainView();
                              },
                            ));
                          },
                          type: QuickAlertType.success,
                          text: 'Basic Details submitted!',
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Please enter all required details!',
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  bool _validateFields() {
    return _fullNameController.text.isNotEmpty &&
        _addressController.text.isNotEmpty &&
        _contactNumberController.text.isNotEmpty &&
        _landmarkController.text.isNotEmpty &&
        _nearestCustomerController.text.isNotEmpty;
  }

  void submitDetails() {
    String fullName = _fullNameController.text;
    String address = _addressController.text;
    String contactNumber = _contactNumberController.text;
    String landmark = _landmarkController.text;
    String nearestCustomer = _nearestCustomerController.text;

    Map<String, String> requestBody = {
      'name': fullName,
      'address': address,
      'contact_number': contactNumber,
      'landmark': landmark,
      'nearest_existing_customer': nearestCustomer,
    };

    http
        .post(
      Uri.parse(
          'http://localhost/nwd/representative/basic_details_representative.php'),
      body: requestBody,
    )
        .then((response) {
      if (response.statusCode == 200) {
        print('Data submitted successfully');
      } else {
        print('Error occurred: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error occurred: $error');
    });
  }

  Widget textField(
      Icon icon, String label, double width, TextEditingController controller) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: icon,
                labelText: label,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
