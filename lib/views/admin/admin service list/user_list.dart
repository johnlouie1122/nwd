// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20service%20list/add_user.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:http/http.dart' as http;

class UserAccounts extends StatefulWidget {
  const UserAccounts({super.key});

  @override
  State<UserAccounts> createState() => _UserAccountsState();
}

class _UserAccountsState extends State<UserAccounts> {
  List<dynamic> serviceData = [];
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredServiceData = [];

  @override
  void initState() {
    super.initState();
    fetchServiceData();
  }

  Future<void> fetchServiceData() async {
    final response = await http.get(
        Uri.parse('http://localhost/nwd/admin/get_servicelist.php?table=user'));
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

  Color _getStatusColor(String status) {
    if (status == 'active') {
      return Colors.green;
    } else if (status == 'inactive') {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Accounts List',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddUser();
              });
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
                  final id = service['id'];
                  final firstName = service['firstName'];
                  final lastName = service['lastName'];
                  final username = service['username'];
                  final password = service['password'];
                  final role = service['role'];
                  final status = service['status'];

                  return ListTile(
                    hoverColor: Colors.blue.shade100,
                    tileColor: tileColor,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstName,
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
                              child: Text('User Details'),
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
                                              'FIRST NAME',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'LAST NAME',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'USER NAME',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'PASSOWRD',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              'ROLE',
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
                                        Text('$firstName',
                                            textAlign: TextAlign.center),
                                        Text('$lastName',
                                            textAlign: TextAlign.center),
                                        Text('$username',
                                            textAlign: TextAlign.center),
                                        Text('$password',
                                            textAlign: TextAlign.center),
                                        Text(
                                          '$role',
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '$status',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: _getStatusColor(status)),
                                        ),
                                      ])
                                    ],
                                  )
                                ],
                              ),
                            ),
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
