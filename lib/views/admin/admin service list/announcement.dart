// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/admin%20service%20list/announcement_list.dart';
import 'package:quickalert/quickalert.dart';

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement({super.key});

  @override
  State<AddAnnouncement> createState() => AddAnnouncementState();
}

class AddAnnouncementState extends State<AddAnnouncement> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void submitDetails() {
    String title = _titleController.text;
    String content = _contentController.text;

    Map<String, String> requestBody = {
      'title': title,
      'content': content,
    };

    http
        .post(
      Uri.parse('http://localhost/nwd/admin/add_announcement.php'),
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
    return _titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ADD ANNOUNCEMENT',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'TITLE',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'CONTENT',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
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
                            return const AnnouncementList();
                          },
                        ));
                      },
                      type: QuickAlertType.success,
                      text: 'Announcement Successfully Posted',
                    );
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'Please enter all required fields!',
                    );
                  }
                },
                child: const Text(
                  'POST',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
