// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';

class CustomerFeedbackList extends StatefulWidget {
  const CustomerFeedbackList({super.key});

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

  Future<void> deleteFeedback(String? id) async {
    if (id != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/delete_customer_feedback.php'),
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        fetchFeedbackList();
      } else {
        print('Error deleting announcement');
      }
    }
  }

  Future<void> markFeedbackAsChecked(String? id) async {
    if (id != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/update_feedback.php'),
        body: {'id': id},
      );
      if (response.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Feedback marked as checked!',
          onConfirmBtnTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const CustomerFeedbackList();
            }));
          },
        );
        fetchFeedbackList();
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Failed to mark as checked!',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Feedback',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: feedbackList.length,
                itemBuilder: (BuildContext context, int index) {
                  var tileColor =
                      index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                  final feedback = feedbackList[index];
                  return ListTile(
                    hoverColor: Colors.blue.shade100,
                    tileColor: tileColor,
                    title: Text(
                      feedback['name'],
                      style: const TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      feedback['type'],
                      style: const TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Customer Name',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  feedback['name'],
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Feedback',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  feedback['feedback'],
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  QuickAlert.show(
                                    context: context,
                                    showCancelBtn: true,
                                    confirmBtnText: 'Yes',
                                    type: QuickAlertType.warning,
                                    text: 'Are you sure you want to delete?',
                                    onConfirmBtnTap: () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Feedback successfully deleted!',
                                        onConfirmBtnTap: () async {
                                          if (feedback['id'] != null) {
                                            deleteFeedback(feedback['id']);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const CustomerFeedbackList(),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'Delete',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () {
                                  QuickAlert.show(
                                    context: context,
                                    showCancelBtn: true,
                                    confirmBtnText: 'Yes',
                                    type: QuickAlertType.warning,
                                    text: 'Are you sure',
                                    onConfirmBtnTap: () async {
                                      markFeedbackAsChecked(feedback['id']);
                                    },
                                  );
                                },
                                child: const Text(
                                  'Mark as Checked',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
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
