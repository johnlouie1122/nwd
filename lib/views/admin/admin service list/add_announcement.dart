// ignore_for_file: avoid_print

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  String? photo;
  List<int>? photobyte;
  List<String?> selectedPhotos = [];
  List<List<int>?> selectedPhotoBytes = [];

  Future<void> chooseFile2() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        photo = result.files.single.name;
        photobyte = result.files.single.bytes;
        selectedPhotos.add(photo);
        selectedPhotoBytes.add(photobyte);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void submitDetails(String db) async {
    String title = _titleController.text;
    String content = _contentController.text;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost/nwd/admin/add.php'),
    );

    request.fields['db'] = db;
    request.fields['title'] = title;
    request.fields['content'] = content;

    for (int i = 0; i < selectedPhotos.length; i++) {
      final fileName = selectedPhotos[i];
      final photoBytes = selectedPhotoBytes[i];

      if (fileName != null && photoBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file${i + 1}',
            photoBytes,
            filename: fileName,
            contentType: MediaType('application', 'octet-stream'),
          ),
        );
      }
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Data submitted successfully');
      } else {
        print('Error occurred: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  Widget fileButton(
    String? fileName,
    String buttonText,
    VoidCallback onPressed,
    bool showRemoveButton,
  ) {
    return Column(
      children: [
        ListTile(
          title: Text(
            fileName == null ? buttonText : '$buttonText ($fileName)',
            style: TextStyle(
              color: fileName != null ? Colors.black : Colors.grey,
            ),
          ),
          trailing: showRemoveButton
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      selectedPhotos.remove(fileName);
                    });
                  },
                  icon: const Icon(Icons.remove),
                )
              : IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.folder),
                ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  bool _validateFields() {
    return _titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ADD ANNOUNCEMENT',
              style: TextStyle(
                color: Colors.blue,
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
            SizedBox(
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
            const SizedBox(height: 10),
            for (int i = 0; i < selectedPhotos.length; i++)
              fileButton(
                selectedPhotos[i],
                'Photo ${i + 1}',
                () {},
                i == selectedPhotos.length - 1,
              ),
            if (selectedPhotos.length < 5)
              SizedBox(
                width: MediaQuery.of(context).size.width /2,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    chooseFile2();
                  },
                  child: const Text('Attach Photo/s'),
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
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
                    submitDetails('announcements');
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
