// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController declineReasonController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  final twilioFlutter = TwilioFlutter(
    accountSid: 'AC99e89e20dfaa62ca55f82d16ec644a81',
    authToken: '36e8bd7cfde18101d667db6e69b25212',
    twilioNumber: '+13083368459',
  );

  List<String> originalApplicants = [];
  List<String> applicants = [];
  List<String> applicantFiles = [];
  List<String> status = [];
  List<String> name = [];
  List<String> address = [];
  List<String> contactNumber = [];
  List<String> type = [];
  List<String> landmark = [];
  List<String> nearestExistingCustomer = [];
  List<String> orientationStatus = [];
  List<String> certificateCode = [];

  @override
  void initState() {
    super.initState();
    fetchApplicants();
    fetchDetails();
    originalApplicants = applicants;
  }

  Future<void> fetchApplicants() async {
    Uri url = Uri.parse('http://localhost/nwd/admin/applicants.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> names = [];
      for (var name in jsonData) {
        names.add(name);
      }
      setState(() {
        applicants = names;
        originalApplicants = List.from(names);
      });
    } else {
      print('Failed to fetch applicants: ${response.statusCode}');
    }
  }

  Future<void> fetchDetails() async {
    Uri url = Uri.parse('http://localhost/nwd/admin/status.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> statusData = [];
      List<String> nameData = [];
      List<String> addressData = [];
      List<String> contactNumberData = [];
      List<String> typeData = [];
      List<String> landmarkData = [];
      List<String> nearestExistingCustomerData = [];
      List<String> orientationStatusData = [];
      List<String> certificateCodeData = [];

      for (var data in jsonData) {
        statusData.add(data['status']);
        nameData.add(data['name']);
        addressData.add(data['address']);
        contactNumberData.add(data['contact_number']);
        typeData.add(data['type']);
        landmarkData.add(data['landmark']);
        nearestExistingCustomerData.add(data['nearest_existing_customer']);
        orientationStatusData.add(data['orientation_status']);
        certificateCodeData.add(data['certificate_code']);
      }
      setState(() {
        status = statusData;
        name = nameData;
        address = addressData;
        contactNumber = contactNumberData;
        type = typeData;
        landmark = landmarkData;
        nearestExistingCustomer = nearestExistingCustomerData;
        orientationStatus = orientationStatusData;
        certificateCode = certificateCodeData;
      });
    } else {
      print('Failed to fetch status: ${response.statusCode}');
    }
  }

  Future<void> updateApplicantStatus(String applicantName, String status,
      int index, String type, String declineReason) async {
    Random random = Random();
    int randomNumber = random.nextInt(900000) + 100000;
    Uri url =
        Uri.parse('http://localhost/nwd/admin/update_applicant_status.php');
    final response = await http.post(url, body: {
      'applicantName': applicantName,
      'status': status,
      'randomNumber': randomNumber.toString(),
      'type': type,
    });

    if (response.statusCode == 200) {
      if (status == 'FOR EVALUATION') {
        await twilioFlutter.sendSMS(
          messageBody:
              'Nasipit Water District: Your online new water connection is now set for Evaluation. Here is your step 2 code: $randomNumber. Use this code if you already have all the requirements for step 2',
          toNumber: contactNumber[index],
        );
      } else if (status == 'DECLINED') {
        await twilioFlutter.sendSMS(
          messageBody:
              'Nasipit Water District: We regret to inform you that your request for a new water connection has been declined. Reason: $declineReason',
          toNumber: contactNumber[index],
        );
      } else if (status == 'APPROVED') {
        await twilioFlutter.sendSMS(
          messageBody:
              'Nasipit Water District: Congratulations! Your request for a new water connection has been approved. Please submit a copy of your submitted details and pay the new water connection fees at the Nasipit Water District office. Thank you!',
          toNumber: contactNumber[index],
        );  
         } else if (status == 'ORIENTATION') {
        await twilioFlutter.sendSMS(
          messageBody:
              'Nasipit Water District: Your Online new water connection is now set for Orientation, here is your orientation code: $randomNumber',
          toNumber: contactNumber[index],
        );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const AdminHomePage();
          },
        ),
      );
    } else {
      print('Failed to update status: ${response.statusCode}');
    }
  }

  Future<void> fetchApplicantFiles(String applicant) async {
    Uri filesUrl = Uri.parse('http://localhost/nwd/files.php?name=$applicant');
    final filesResponse = await http.get(filesUrl);

    if (filesResponse.statusCode == 200) {
      final filesData = jsonDecode(filesResponse.body) as List<dynamic>;
      setState(() => applicantFiles.addAll(filesData.cast<String>()));
    } else {
      print('Failed to fetch files for applicant: $applicant');
    }
  }

  Future<void> deleteApplicant(String applicantName) async {
    Uri deleteUrl =
        Uri.parse('http://localhost/nwd/admin/delete_applicant.php');
    final response =
        await http.post(deleteUrl, body: {'applicantName': applicantName});

    if (response.statusCode == 200) {
    } else {
      print('Failed to delete applicant: ${response.statusCode}');
    }
  }

  Color _getStatusColor(String status) {
    if (status == 'APPROVED') {
      return Colors.green;
    } else if (status == 'DECLINED') {
      return Colors.red;
    } else if (status == 'PENDING (FOR EVALUATION)') {
      return Colors.blue;
    } else if (status == 'PENDING (REQUIREMENTS)') {
      return Colors.blue;
    } else if (status == 'FOR EVALUATION') {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Water Service Applicant List',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
        actions: [
          Image.asset('assets/images/logo.png'),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blue,
                  elevation: 5,
                  child: SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Search Applicant Name',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        onChanged: (value) {
                          searchApplicants(value);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'APPLICANT NAME',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'STATUS',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: applicants.length,
                  itemBuilder: (context, index) {
                    var tileColor =
                        index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                    return ListTile(
                      hoverColor: Colors.blue.shade100,
                      tileColor: tileColor,
                      title: Text(
                        applicants[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                      trailing: status.length > index
                          ? Text(
                              status[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: _getStatusColor(status[index]),
                              ),
                            )
                          : null,
                      onTap: () async => await fetchApplicantFiles(
                        rr(applicants[index]),
                      ).then(
                        (value) => showApplicantFiles(applicants[index], index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String rr(String text) => text.replaceAll(' ', '%20');

  showApplicantFiles(String applicant, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text(
              'APPLICANT DETAILS',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          content: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                        borderRadius: BorderRadius.circular(10)),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        children: [
                          TableCell(
                            child: Text(
                              'NAME',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'ADDRESS',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'CONTACT NUMBER',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'LANDMARK',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'NEAREST EXISTING CUSTOMER',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'TYPE',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'ORIENTATION STATUS',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'CERTIFICATE CODE',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        Text(name[index], textAlign: TextAlign.center),
                        Text(address[index], textAlign: TextAlign.center),
                        Text(contactNumber[index], textAlign: TextAlign.center),
                        Text(landmark[index], textAlign: TextAlign.center),
                        Text(
                          nearestExistingCustomer[index],
                          textAlign: TextAlign.center,
                        ),
                        Text(type[index], textAlign: TextAlign.center),
                        Text(orientationStatus[index],
                            textAlign: TextAlign.center),
                        Text(certificateCode[index],
                            textAlign: TextAlign.center),
                      ])
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  itemCount: applicantFiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, gvIndex) {
                    var imageURL =
                        'http://localhost/nwd/uploads/${rr(applicant)}/${rr(applicantFiles[gvIndex])}';
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImage(imageURL: imageURL),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              applicantFiles[gvIndex],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AdminHomePage();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Close',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
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
                    type: QuickAlertType.error,
                    title: 'Warning . . .',
                    text: 'Are you sure you want to Delete?',
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () async {
                      await deleteApplicant(applicant);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AdminHomePage();
                          },
                        ),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
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
                    type: QuickAlertType.error,
                    title: 'Warning . . . ',
                    text: 'Are you sure you want to Decline?',
                  widget:  TextField(
                      controller: declineReasonController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                     
                        labelText: 'Reason for declining',
                      ),
                    ),
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () async {
                      String declineReason = declineReasonController.text; 
                      await updateApplicantStatus(
                        applicant,
                        'DECLINED',
                        index,
                        type[index],
                        declineReason
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AdminHomePage();
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Decline',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    showCancelBtn: true,
                    type: QuickAlertType.success,
                    title: 'Confirmation',
                    text: 'Are you sure?',
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () async {
                      await updateApplicantStatus(
                          applicant, 'FOR EVALUATION', index, type[index], '');
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AdminHomePage();
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Evaluation',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                   QuickAlert.show(
                    context: context,
                    showCancelBtn: true,
                    type: QuickAlertType.success,
                    title: 'Confirmation',
                    text: 'Are you sure?',
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () async {
                      await updateApplicantStatus(
                          applicant, 'ORIENTATION', index, type[index], '');
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const AdminHomePage();
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Orientation',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'Cancel',
                    showCancelBtn: true,
                    type: QuickAlertType.success,
                    title: 'Confirmation . . .',
                    text: 'Are you sure you want to Approve?',
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    onConfirmBtnTap: () async {
                      await updateApplicantStatus(
                          applicant, 'APPROVED', index, type[index], '');
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AdminHomePage();
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Approve',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void searchApplicants(String query) {
    final lowercaseQuery = query.toLowerCase();
    if (lowercaseQuery.isEmpty) {
      setState(() {
        applicants = List.from(originalApplicants);
      });
    } else {
      final filteredApplicants = originalApplicants.where((applicant) {
        final lowercaseApplicant = applicant.toLowerCase();
        return lowercaseApplicant.contains(lowercaseQuery);
      }).toList();

      setState(() {
        applicants = filteredApplicants;
      });
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final imageURL;
  const FullScreenImage({super.key, this.imageURL});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Image.network(imageURL),
          ),
        ),
      );
}
