import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quickalert/quickalert.dart';

class DisconnectionList extends StatefulWidget {
  const DisconnectionList({super.key});

  @override
  State<DisconnectionList> createState() => _DisconnectionListState();
}

class _DisconnectionListState extends State<DisconnectionList> {
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
        .get(Uri.parse('http://localhost/nwd/admin/get_servicelist.php?table=disconnection'));
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

  Future<void> updateStatus(String id, String status, String table) async {
    final url =
        Uri.parse('http://localhost/nwd/admin/update_status.php');
    final response = await http.post(
      url,
      body: {
        'id': id,
        'status': status,
        'table': table,
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
        title: const Text(
          'Disconnection',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
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
                  var tileColor =
                      index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                  final service = filteredServiceData[index];
                  final accountName = service['account_name'];
                  final id = service['id'];
                  final date = service['date'];
                  final accountNumber = service['account_number'];
                  final address = service['address'];
                  final contactNumber = service['contact'];
                  final landmark = service['landmark'];

                  final status = service['status'];

                  return ListTile(
                    hoverColor: Colors.blue.shade100,
                    tileColor: tileColor,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountName,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          DateFormat('MMMM d, y').format(
                            DateTime.parse(date),
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          status,
                          style: TextStyle(
                              fontSize: 15, color: _getStatusColor(status)),
                        ),
                      ],
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                  ),
                                  Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    border: TableBorder.all(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                              'DATE',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'ACCOUNT NAME',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'ACCOUNT NUMBER',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'ADDRESS',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'LANDMARK',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'CONTACT NUMBER',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'STATUS',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(children: [
                                        Text('$date',
                                            textAlign: TextAlign.center),
                                        Text('$accountName',
                                            textAlign: TextAlign.center),
                                        Text('$accountNumber',
                                            textAlign: TextAlign.center),
                                        Text('$address',
                                            textAlign: TextAlign.center),
                                        Text(
                                          '$landmark',
                                          textAlign: TextAlign.center,
                                        ),
                                        Text('$contactNumber',
                                            textAlign: TextAlign.center),
                                        Text('$status',
                                            textAlign: TextAlign.center),
                                      ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
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
                                    title: 'Confirmation. . .',
                                    text: 'Are you sure you want to Decline?',
                                    onConfirmBtnTap: () {
                                      updateStatus(id, 'DECLINED', 'disconnection');
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return const DisconnectionList();
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
                              ElevatedButton(
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
                                    confirmBtnText: 'Yes',
                                    type: QuickAlertType.success,
                                    title: 'Confirmation. . .',
                                    text: 'Are you sure you want to Approve?',
                                    onConfirmBtnTap: () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Service Successfully Approved',
                                        onConfirmBtnTap: () {
                                          updateStatus(id, 'APPROVED', 'disconnection');
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return const DisconnectionList();
                                              },
                                            ),
                                          );
                                        },
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
                            ],
                          );
                        },
                      );
                    },
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
