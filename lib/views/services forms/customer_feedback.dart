// ignore_for_file: avoid_print, depend_on_referenced_packages, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:html' as html;

class CustomerFeedback extends StatefulWidget {
  const CustomerFeedback({super.key});

  @override
  CustomerFeedbackState createState() => CustomerFeedbackState();
}

class CustomerFeedbackState extends State<CustomerFeedback> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _openWebsiteURL(String url) {
    html.window.open(url, '_blank');
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void submitDetails() {
    String feedback = _feedbackController.text;
    String name = _nameController.text;

    if (name.isEmpty) {
      name = 'Anonymous';
    }

    Map<String, String> requestBody = {
      'feedback': feedback,
      'name': name,
    };

    http
        .post(
      Uri.parse('https://capstone.smccnasipit.edu.ph/ocsms-nwd/user-services/customer_feedback.php'),
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

  bool _validateFields() {
    return _feedbackController.text.isNotEmpty;
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width,
              ),
              const Text(
                'CUSTOMER FEEDBACK',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 500,
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'NAME (OPTIONAL)',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 500,
                  child: TextField(
                    maxLines: null,
                    controller: _feedbackController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'FEEDBACK',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 500,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
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
                      'SUBMIT',
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
    );
  }
}
