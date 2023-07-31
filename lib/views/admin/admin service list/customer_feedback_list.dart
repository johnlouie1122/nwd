// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';

class CustomerFeedbackList extends StatefulWidget {
  const CustomerFeedbackList({Key? key}) : super(key: key);

  @override
  State<CustomerFeedbackList> createState() => _CustomerFeedbackListState();
}

class _CustomerFeedbackListState extends State<CustomerFeedbackList> {
  List<dynamic> feedbackList = [];

  @override
  void initState() {
    super.initState();
    fetchFeedbackList();
  }

  Future<void> fetchFeedbackList() async {
    final response = await http
        .get(Uri.parse('http://localhost/nwd/admin/feedback_list.php'));

    if (response.statusCode == 200) {
      setState(() {
        feedbackList = json.decode(response.body);
      });
    } else {}
  }

  Future<void> deleteFeedback(String? name) async {
    if (name != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/delete_customer_feedback.php'),
        body: {'name': name},
      );
      if (response.statusCode == 200) {
        fetchFeedbackList();
      } else {
        print('Error deleting announcement');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Feedback'),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'CUSTOMER FEEDBACK LIST',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Colors.blue,
                    shadows: [
                      Shadow(
                        color: Colors.blue.shade800,
                        offset: const Offset(2, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: feedbackList.length,
                itemBuilder: (BuildContext context, int index) {
                  final feedback = feedbackList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          feedback['name'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Center(
                                child: Text('Feedback'),
                              ),
                              content: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Text(feedback['feedback'])),
                                  ],
                                ),
                              ),
                              actions: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      QuickAlert.show(
                                        context: context,
                                        showCancelBtn: true,
                                        confirmBtnText: 'Yes',
                                        type: QuickAlertType.warning,
                                        text:
                                            'Are you sure you want to delete?',
                                        onConfirmBtnTap: () {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            text:
                                                'Feedback successfully deleted!',
                                            onConfirmBtnTap: () async {
                                              if (feedback['name'] != null) {
                                                deleteFeedback(
                                                    feedback['name']);
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const CustomerFeedbackList(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              }
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Delete', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
