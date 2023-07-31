// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';

class PendingServiceList extends StatefulWidget {
  const PendingServiceList({Key? key}) : super(key: key);

  @override
  State<PendingServiceList> createState() => _PendingServiceListState();
}

class _PendingServiceListState extends State<PendingServiceList> {
  List<dynamic> serviceData = [];
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredServiceData = [];

  @override
  void initState() {
    super.initState();
    fetchServiceData();
  }

  Future<void> fetchServiceData() async {
    final response = await http
        .get(Uri.parse('http://localhost/nwd/admin/get_service_data.php'));
    if (response.statusCode == 200) {
      setState(() {
        serviceData = json.decode(response.body);
        filteredServiceData = List.from(serviceData);
      });
    }
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredServiceData = serviceData
            .where((service) => service['account_name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredServiceData = List.from(serviceData);
      });
    }
  }

  Future<void> updateStatus(String accountName, String status) async {
    final url =
        Uri.parse('http://localhost/nwd/admin/update_service_status.php');
    final response = await http.post(
      url,
      body: {
        'accountName': accountName,
        'status': status,
      },
    );

    if (response.statusCode == 200) {
      print('Status updated successfully');
    } else {
      print('Error updating status: ${response.body}');
    }
  }

  Color _getStatusColor(String status) {
    if (status == 'APPROVED') {
      return Colors.green;
    } else if (status == 'DECLINED') {
      return Colors.red;
    } else if (status == 'PENDING') {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Service Requests'),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'PENDING SERVICE LIST',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Colors.blue,
                    shadows: [
                      Shadow(
                        color: Colors.blue.shade800,
                        offset: const Offset(2, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
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
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        cursorColor: Colors.white,
                        onChanged: filterSearchResults,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Search by Name',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredServiceData.length,
                itemBuilder: (context, index) {
                  final service = filteredServiceData[index];
                  final accountName = service['account_name'];
                  final type = service['type'];
                  final date = service['date'];
                  final accountNumber = service['account_number'];
                  final address = service['address'];
                  final contactNumber = service['contact_number'];
                  final landmark = service['landmark'];
                  final previousReading = service['previous_reading'];
                  final currentReading = service['current_reading'];
                  final consumption = service['consumption'];
                  final status = service['status'];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          accountName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 300,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              type ,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              status,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(status)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Center(
                                child: Text('Applicant Details'),
                              ),
                              content: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('DATE: $date'),
                                    Text('TYPE: $type'),
                                    Text('ACCOUNT NAME: $accountName'),
                                    Text('ACCOUNT NUMBER: $accountNumber'),
                                    Text('ADDRESS: $address'),
                                    Text('CONTACT NUMBER: $contactNumber'),
                                    Text('LANDMARK: $landmark'),
                                    Text('PREVIOUS READING: $previousReading'),
                                    Text('CURRENT READING: $currentReading'),
                                    Text('CONSUMPTION: $consumption'),
                                    Text('STATUS: $status'),
                                  ],
                                ),
                              ),
                              actions: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      QuickAlert.show(
                                        context: context,
                                        showCancelBtn: true,
                                        confirmBtnText: 'Yes',
                                        type: QuickAlertType.error,
                                        title: 'Confirmation. . .',
                                        text:
                                            'Are you sure you want to Decline?',
                                        onConfirmBtnTap: () {
                                          updateStatus(accountName, 'DECLINED');
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return const PendingServiceList();
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Decline', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 120,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      QuickAlert.show(
                                        context: context,
                                        showCancelBtn: true,
                                        confirmBtnText: 'Yes',
                                        type: QuickAlertType.success,
                                        title: 'Confirmation. . .',
                                        text:
                                            'Are you sure you want to Approve?',
                                        onConfirmBtnTap: () {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            text:
                                                'Service Successfully Approved',
                                            onConfirmBtnTap: () {
                                              updateStatus(
                                                  accountName, 'APPROVED');
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return const PendingServiceList();
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Approve', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
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
