import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/list%20forms/customer_feedback_list.dart';
import 'package:nwd/views/admin/list%20forms/service_rating.dart/add_account.dart';
import 'package:nwd/views/admin/list%20forms/service_rating.dart/pending_service_list.dart';
import 'package:nwd/views/admin/list%20forms/service_rating.dart/service_rating_list.dart';
import 'package:nwd/views/admin/login.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<String> applicants = [];
  List<String> applicantFiles = [];

  @override
  void initState() {
    super.initState();
    fetchApplicants();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const AdminLogin(),
              ),
            ),
            child: const Text(
              'LOGOUT',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const Text(
              'MENU',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Customer Feedback'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const CustomerFeedbackList();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Service Rating'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ServiceRatingList();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Add Customer Acoount'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AddAccount();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Pending Service List'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const PendingServiceList();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pending Applicants',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    applicants[index],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async => await fetchApplicantFiles(
                          noSpaces(applicants[index]))
                      .then((value) => showApplicantFiles(applicants[index])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String noSpaces(String text) => text.replaceAll(' ', '%20');

  showApplicantFiles(String applicant) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Center(
              child: Text('APPLICANT DETAILS'),
            ),
            content: Column(
              children: [
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
                            'http://localhost/nwd/uploads/${noSpaces(applicant)}/${noSpaces(applicantFiles[gvIndex])}';
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
                              color: Colors.black
                                  .withOpacity(0.5), // Adjust the opacity here
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
                  onPressed: () => Navigator.pop(context),
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
                                onPressed: () {
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
                                onPressed: () {
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
          child: Center(child: Image.network(imageURL))));
}
