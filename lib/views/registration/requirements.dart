// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../login/login.dart';

class Requirements extends StatefulWidget {
  const Requirements({Key? key}) : super(key: key);

  @override
  State<Requirements> createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements> {
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please choose all files before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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
      Uri.parse('http://localhost/nwd/requirements.php'),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Success!'),
            content: const Center(
              child: Column(
                children: [
                  Text('Application Submitted'),
                  Text('Please wait for our update via SMS'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // File upload failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Error'),
            content: const Text('Failed to upload the files.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget textField(TextEditingController controller, Icon icon, String label) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
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
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        leading: IconButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Warning!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Are you sure you want to cancel the process?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: AlertDialog(
        scrollable: true,
        content: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
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
            ),
            const SizedBox(
              height: 10,
            ),
            textField(
              _addressController,
              const Icon(Icons.location_on_rounded),
              'ADDRESS',
            ),
            const SizedBox(height: 10),
            textField(
              _contactNumberController,
              const Icon(Icons.numbers_rounded),
              'CONTACT NUMBER',
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
            fileButton(authorization, 'Authorization', chooseFile6),
            fileButton(
              validIdRepresentative,
              'Valid ID Representative',
              chooseFile7,
            ),
            ElevatedButton(
              onPressed: submitFile,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
