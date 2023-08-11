// ignore_for_file: use_build_context_synchronously
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:quickalert/quickalert.dart';

class RequirementsMainApplicant extends StatefulWidget {
  final Map<String, dynamic> userData;

  const RequirementsMainApplicant({super.key, required this.userData});

  @override
  State<RequirementsMainApplicant> createState() =>
      _RequirementsMainApplicantState();
}

class _RequirementsMainApplicantState extends State<RequirementsMainApplicant> {
  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(900000) + 100000;
  }

  String? waterpermit;
  String? waiver;
  String? lotTitle;
  String? validID;
  String? brgyCertificate;

  List<int>? waterpermitbyte;
  List<int>? waiverbyte;
  List<int>? lotTitlebyte;
  List<int>? validIDbyte;
  List<int>? brgyCertificatebyte;

  Future<void> chooseFile1() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        waterpermit = result.files.single.name;
        waterpermitbyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile2() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        waiver = result.files.single.name;
        waiverbyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile3() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        lotTitle = result.files.single.name;
        lotTitlebyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile4() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        validID = result.files.single.name;
        validIDbyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile5() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        brgyCertificate = result.files.single.name;
        brgyCertificatebyte = result.files.single.bytes;
      });
    }
  }

  Future<void> submitFile() async {
    final randomNumber = generateRandomNumber();

    if (waterpermitbyte == null ||
        waiverbyte == null ||
        lotTitlebyte == null ||
        validIDbyte == null ||
        brgyCertificatebyte == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Please choose all files before submitting.',
      );
      return;
    }

    final waterpermitName = waterpermit!;
    final waiverName = waiver!;
    final lotTitleName = lotTitle!;
    final validIDName = validID!;
    final brgyCertificateName = brgyCertificate!;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost/nwd/requirements_main_customer.php'),
    );
    request.fields['name'] = widget.userData['name'];
    request.fields['randomNumber'] = randomNumber.toString();
    request.files.add(
      http.MultipartFile.fromBytes(
        'file1',
        waterpermitbyte!,
        filename: waterpermitName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file2',
        waiverbyte!,
        filename: waiverName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file3',
        lotTitlebyte!,
        filename: lotTitleName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file4',
        validIDbyte!,
        filename: validIDName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file5',
        brgyCertificatebyte!,
        filename: brgyCertificateName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    final response = await request.send();
    if (response.statusCode == 200) {
      QuickAlert.show(
        barrierDismissible: false,
        context: context,
        title: 'Application Submitted!',
        onConfirmBtnTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return const MainView();
            },
          ));
        },
        type: QuickAlertType.success,
        text:
            'An SMS code will be sent to your contact number \nto proceed with your orientation',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Failed to Upload Files',
      );
    }
  }

  Widget fileButton(
      String? fileName, String buttonText, VoidCallback onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          ListTile(
            title: Text(
              fileName == null ? buttonText : '$buttonText ($fileName)',
              style: TextStyle(
                color: fileName != null ? Colors.black : Colors.grey,
              ),
            ),
            trailing: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.folder),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 20,
              ),
              const Text(
                'MAIN APPLICANT FORM',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.userData['name'],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userData['address'],
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.userData['contactNumber'],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 30.0),
              const Text(
                'UPLOAD REQUIREMENTS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              fileButton(waterpermit, 'Water Permit', chooseFile1),
              fileButton(waiver, 'Waiver', chooseFile2),
              fileButton(lotTitle, 'Lot Title', chooseFile3),
              fileButton(validID, 'Valid ID', chooseFile4),
              fileButton(brgyCertificate, 'Barangay Certificate', chooseFile5),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: submitFile,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
