// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nwd/views/New%20Water%20Connection/widgets/appbar/registration_appbar.dart';
import 'package:quickalert/quickalert.dart';

import '../widgets/requirements widget/file_button_widget.dart';
import '../widgets/requirements widget/textfield_widget.dart';

class RequirementsRepresentative extends StatefulWidget {
  const RequirementsRepresentative({Key? key}) : super(key: key);

  @override
  State<RequirementsRepresentative> createState() =>
      _RequirementsRepresentativeState();
}

class _RequirementsRepresentativeState
    extends State<RequirementsRepresentative> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  String? waterpermit;
  String? waiver;
  String? lotTitle;
  String? validID;
  String? brgyCertificate;
  String? authorization;
  String? validIdRepresentative;

  List<int>? waterpermitbyte;
  List<int>? waiverbyte;
  List<int>? lotTitlebyte;
  List<int>? validIDbyte;
  List<int>? brgyCertificatebyte;
  List<int>? authorizationbyte;
  List<int>? validIdRepresentativebyte;

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

  Future<void> chooseFile6() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        authorization = result.files.single.name;
        authorizationbyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile7() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        validIdRepresentative = result.files.single.name;
        validIdRepresentativebyte = result.files.single.bytes;
      });
    }
  }

  Future<void> submitFile() async {
    final name = _nameController.text;
    final address = _addressController.text;
    final contactNumber = _contactNumberController.text;

    if (name.isEmpty || address.isEmpty || contactNumber.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Please fill in all the required fields',
      );
      return;
    }

    if (waterpermitbyte == null ||
        waiverbyte == null ||
        lotTitlebyte == null ||
        validIDbyte == null ||
        brgyCertificatebyte == null ||
        authorizationbyte == null ||
        validIdRepresentativebyte == null) {
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
    final authorizationName = authorization!;
    final validIdRepresentativeName = validIdRepresentative!;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost/nwd/requirements_representative.php'),
    );
    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['contactNumber'] = contactNumber;
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
    request.files.add(
      http.MultipartFile.fromBytes(
        'file6',
        authorizationbyte!,
        filename: authorizationName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file7',
        validIdRepresentativebyte!,
        filename: validIdRepresentativeName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200) {
      // File upload successful
      QuickAlert.show(
        barrierDismissible: false,
        context: context,
        title: 'Application Submitted!',
        onConfirmBtnTap: () {
        
        },
        type: QuickAlertType.success,
        text: 'An SMS update will be sent to your contact number',
      );
    } else {
      // File upload failed
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Failed to Upload Files',
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistrationAppbar(
        context: context,
        title: const Text('Requirements for Application'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
        ),
        child: AlertDialog(
          scrollable: true,
          content: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
              ),
              const Text(
                'Representative Form',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'ENTER BASIC DETAILS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textField(
                _nameController,
                const Icon(Icons.person_rounded),
                'FULL NAME',
                MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 10,
              ),
              textField(
                _addressController,
                const Icon(Icons.location_on_rounded),
                'ADDRESS',
                MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 10),
              textField(
                _contactNumberController,
                const Icon(Icons.numbers_rounded),
                'CONTACT NUMBER',
                MediaQuery.of(context).size.width / 2,
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
              fileButton(
                waterpermit,
                'Water Permit',
                chooseFile1,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                waiver,
                'Waiver',
                chooseFile2,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                lotTitle,
                'Lot Title',
                chooseFile3,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                validID,
                'Valid ID (Main Applicant)',
                chooseFile4,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                brgyCertificate,
                'Barangay Certificate',
                chooseFile5,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                authorization,
                'Authorization',
                chooseFile6,
                MediaQuery.of(context).size.width / 2,
              ),
              fileButton(
                validIdRepresentative,
                'Valid ID (Representative)',
                chooseFile7,
                MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: submitFile,
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
