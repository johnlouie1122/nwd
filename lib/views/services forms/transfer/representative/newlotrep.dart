// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import '../../../../main_view_widgets/appbar.dart';
import '../../../../main_view_widgets/dialog.dart';
import '../../../../main_view_widgets/routes.dart';
import '../../../../main_view_widgets/sidebar.dart';
import '../../main.view.dart';
import '../transfer_ownership.dart';

class NewLotRep extends StatefulWidget {
  const NewLotRep({super.key});

  @override
  State<NewLotRep> createState() => _NewLotRepState();
}

class _NewLotRepState extends State<NewLotRep> {
  TextEditingController oldAccountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController newAccountNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  String? repId;
  String? deedSale;

  List<int>? repIdbyte;
  List<int>? deedSalebyte;

  Future<void> chooseFile1() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        repId = result.files.single.name;
        repIdbyte = result.files.single.bytes;
      });
    }
  }

  Future<void> chooseFile2() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        deedSale = result.files.single.name;
        deedSalebyte = result.files.single.bytes;
      });
    }
  }

  Future<void> submitFile(String reason) async {
    if (repIdbyte == null || deedSalebyte == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error...',
        text: 'Please choose all files before submitting.',
      );
      return;
    }
    final oldAccountName = oldAccountNameController.text;
    final accountNumber = accountNumberController.text;
    final newAccountName = newAccountNameController.text;
    final contactNumber = contactNumberController.text;
    final repIdName = repId!;
    final deedSaleName = deedSale!;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost/nwd/transfer/representative/newlotrep.php'),
    );
    request.fields['oldAccountName'] = oldAccountName;
    request.fields['accountNumber'] = accountNumber;
    request.fields['newAccountName'] = newAccountName;
    request.fields['contactNumber'] = contactNumber;
    request.fields['reason'] = reason;

    request.files.add(
      http.MultipartFile.fromBytes(
        'file1',
        repIdbyte!,
        filename: repIdName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file2',
        deedSalebyte!,
        filename: deedSaleName,
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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return const MainView();
          }), (route) => false);
        },
        type: QuickAlertType.success,
        text: 'Please wait for our SMS update',
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
      width: 500,
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
              } else if (value.route == '/transfer-ownership') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const TransferDialog();
                    });
              }
            })
          : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Text(
                    'Transfer of Ownership\n(Representative)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: oldAccountNameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Old Account Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: accountNumberController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        labelText: 'Account Number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: newAccountNameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.person_add),
                        border: OutlineInputBorder(),
                        labelText: 'New Account Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: contactNumberController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(),
                        labelText: 'Contact Number',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  fileButton(
                      repId, 'Representative valid ID', chooseFile1),
                  const SizedBox(height: 10),
                  fileButton(deedSale, 'PROOF OF LAND OWNERSHIP', chooseFile2),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: 500,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        submitFile('NEW PROPERTY OWNER');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'SUBMIT REQUEST',
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
        ),
      ),
    );
  }
}
