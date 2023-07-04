// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/adminappbar.dart';
import '../widgets/admindrawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<String> applicants = [];
  List<String> applicantFiles = [];
  List<String> status = [];
  List<String> name = [];
  List<String> address = [];
  List<String> contactNumber = [];
  List<String> type = [];

  @override
  void initState() {
    super.initState();
    fetchApplicants();
    fetchDetails();
  }

  Future<void> fetchApplicants() async {
    Uri url = Uri.parse('http://localhost/nwd/applicants.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> names = [];
      for (var name in jsonData) {
        names.add(name);
      }
      setState(() => applicants = names);
    } else {
      print('Failed to fetch applicants: ${response.statusCode}');
    }
  }

  Future<void> fetchDetails() async {
    Uri url = Uri.parse('http://localhost/nwd/status.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> statusData = [];
      List<String> nameData = [];
      List<String> addressData = [];
      List<String> contactNumberData = [];
      List<String> typeData = [];

      for (var data in jsonData) {
        statusData.add(data['status']);
        nameData.add(data['name']);
        addressData.add(data['address']);
        contactNumberData.add(data['contact_number']);
        typeData.add(data['type']);
      }
      setState(() {
        status = statusData;
        name = nameData;
        address = addressData;
        contactNumber = contactNumberData;
        type = typeData;
      });
    } else {
      print('Failed to fetch status: ${response.statusCode}');
    }
  }

  Future<void> updateApplicantStatus(
      String applicantName, String status) async {
    Uri url = Uri.parse('http://localhost/nwd/update_status.php');
    final response = await http.post(url, body: {
      'applicantName': applicantName,
      'status': status,
    });

    if (response.statusCode == 200) {
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

  Color _getStatusColor(String status) {
    if (status == 'APPROVED') {
      return Colors.green;
    } else if (status == 'DECLINED') {
      return Colors.red;
    } else if (status == 'PENDING') {
      return Colors.yellow;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      drawer: const DrawerWidget(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text(
              'Water Service Applicant List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: applicants.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          applicants[index],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        trailing: status.length > index
                            ? Text(
                                status[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: _getStatusColor(status[index]),
                                ),
                              )
                            : null,
                        onTap: () async => await fetchApplicantFiles(
                                rr(applicants[index]))
                            .then((value) =>
                                showApplicantFiles(applicants[index], index)),
                      );
                    },
                  ),
                ),
              ],
            ),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            content: Column(
              children: [
                Text(
                  'NAME: ${name[index]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(
                  height: 10,
                ),
                Text(
                  'ADDRESS: ${address[index]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 const SizedBox(
                  height: 10,
                ),
                Text(
                  'CONTACT NUMBER: ${contactNumber[index]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'TYPE: ${type[index]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      itemCount: applicantFiles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  builder: (_) =>
                                      FullScreenImage(imageURL: imageURL))),
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
                    )),
              ],
            ),
            actions: [
              ElevatedButton(
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
                  child: const Text('Close')),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content:
                              const Text('Are you sure you want to decline?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await updateApplicantStatus(
                                      applicant, 'DECLINED');

                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'))
                          ],
                        );
                      });
                },
                child: const Text('Decline'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content:
                              const Text('Are you sure you want to Approve?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await updateApplicantStatus(
                                      applicant, 'APPROVED');

                                  Navigator.pop(context);
                                },
                                child: const Text('Yes'))
                          ],
                        );
                      });
                },
                child: const Text('Appvove'),
              ),
            ],
          );
        });
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
