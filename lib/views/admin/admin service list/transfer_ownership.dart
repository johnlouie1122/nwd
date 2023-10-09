// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/homepage/adminpage.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';

class TransferOwnerList extends StatefulWidget {
  const TransferOwnerList({super.key});

  @override
  State<TransferOwnerList> createState() => _TransferOwnerListState();
}

class _TransferOwnerListState extends State<TransferOwnerList> {
  TextEditingController declineReasonController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  List<String> id = [];
  List<String> date = [];
  List<String> oldName = [];
  List<String> accountNumber = [];
  List<String> newName = [];
  List<String> contactNumber = [];
  List<String> waiver = [];
  List<String> deedSale = [];
  List<String> death = [];
  List<String> letter = [];
  List<String> repId = [];
  List<String> type = [];
  List<String> reason = [];
  List<String> status = [];

  String getImageUrl(String oldName, String imageName) {
    return 'http://localhost/nwd/transfer/uploads/$oldName/$imageName';
  }

  @override
  void initState() {
    super.initState();

    fetchDetails();
  }

  Future<void> updateStatus(String id, String status, String table) async {
    final url = Uri.parse('http://localhost/nwd/admin/update_status.php');
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

  void showFullScreenImage(String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Image.network(imageUrl),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchDetails() async {
    Uri url = Uri.parse(('http://localhost/nwd/admin/get_servicelist.php?table=transfer_ownership'));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> idData = [];
      List<String> dateData = [];
      List<String> oldNameData = [];
      List<String> accountNumberData = [];
      List<String> newNameData = [];
      List<String> contactNumberData = [];
      List<String> waiverData = [];
      List<String> deedSaleData = [];
      List<String> deathData = [];
      List<String> letterData = [];
      List<String> repIdData = [];
      List<String> typeData = [];
      List<String> reasonData = [];
      List<String> statusData = [];

      for (var data in jsonData) {
        idData.add(data['id']);
        dateData.add(data['date']);
        oldNameData.add(data['old_name']);
        accountNumberData.add(data['account_number']);
        newNameData.add(data['new_name']);
        contactNumberData.add(data['contact_number']);
        waiverData.add(data['waiver']);
        deedSaleData.add(data['deed_sale']);
        deathData.add(data['death']);
        letterData.add(data['letter']);
        repIdData.add(data['rep_id']);
        typeData.add(data['type']);
        reasonData.add(data['reason']);
        statusData.add(data['status']);
      }
      setState(() {
        id = idData;
        date = dateData;
        oldName = oldNameData;
        accountNumber = accountNumberData;
        newName = newNameData;
        contactNumber = contactNumberData;
        waiver = waiverData;
        deedSale = deedSaleData;
        death = deathData;
        letter = letterData;
        repId = repIdData;
        type = typeData;
        reason = reasonData;
        status = statusData;
        date = dateData;
        oldName = oldNameData;
      });
    } else {
      print('Failed to fetch status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer Ownership List',
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
                  itemCount: oldName.length,
                  itemBuilder: (context, index) {
                    var tileColor =
                        index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                    return ListTile(
                        hoverColor: Colors.blue.shade100,
                        tileColor: tileColor,
                        title: Text(
                          oldName[index],
                          style: const TextStyle(fontSize: 15),
                        ),
                        trailing: status.length > index
                            ? Text(
                                status[index],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: _getStatusColor(status[index])),
                              )
                            : null,
                        onTap: () {
                          showDialog(
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
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10))),
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
                                                  'OLD NAME',
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
                                                  'NEW NAME',
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
                                                  'TYPE',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              TableCell(
                                                child: Text(
                                                  'REASON',
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
                                            Text(date[index],
                                                textAlign: TextAlign.center),
                                            Text(oldName[index],
                                                textAlign: TextAlign.center),
                                            Text(accountNumber[index],
                                                textAlign: TextAlign.center),
                                            Text(newName[index],
                                                textAlign: TextAlign.center),
                                            Text(contactNumber[index],
                                                textAlign: TextAlign.center),
                                            Text(
                                              type[index],
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(reason[index],
                                                textAlign: TextAlign.center),
                                            Text(status[index],
                                                textAlign: TextAlign.center),
                                          ]),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (waiver[index].isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                showFullScreenImage(getImageUrl(
                                                    oldName[index],
                                                    waiver[index]));
                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      getImageUrl(
                                                        oldName[index],
                                                        waiver[index],
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.dstATop,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        waiver[index],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (deedSale[index].isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                showFullScreenImage(getImageUrl(
                                                    oldName[index],
                                                    deedSale[index]));
                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      getImageUrl(
                                                        oldName[index],
                                                        deedSale[index],
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.dstATop,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        deedSale[index],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (death[index].isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                showFullScreenImage(getImageUrl(
                                                    oldName[index],
                                                    death[index]));
                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      getImageUrl(
                                                        oldName[index],
                                                        death[index],
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.dstATop,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        death[index],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (letter[index].isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                showFullScreenImage(getImageUrl(
                                                    oldName[index],
                                                    letter[index]));
                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      getImageUrl(
                                                        oldName[index],
                                                        letter[index],
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.dstATop,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        letter[index],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (repId[index].isNotEmpty)
                                            GestureDetector(
                                              onTap: () {
                                                showFullScreenImage(getImageUrl(
                                                    oldName[index],
                                                    repId[index]));
                                              },
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      getImageUrl(
                                                        oldName[index],
                                                        repId[index],
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.dstATop,
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        repId[index],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return const TransferOwnerList();
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
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          QuickAlert.show(
                                            context: context,
                                            showCancelBtn: true,
                                            type: QuickAlertType.error,
                                            title: 'Warning . . .',
                                            text:
                                                'Are you sure you want to Delete?',
                                            onCancelBtnTap: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirmBtnTap: () {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return const AdminHomePage();
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
                                            title: 'Warning . . . ',
                                            text:
                                                'Are you sure you want to Decline?',
                                            widget: TextField(
                                              controller:
                                                  declineReasonController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Reason for declining',
                                              ),
                                            ),
                                            onCancelBtnTap: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirmBtnTap: () {
                                              updateStatus(
                                                  id[index],
                                                  'DECLINED',
                                                  'transfer_ownership');
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return const TransferOwnerList();
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
                                            borderRadius:
                                                BorderRadius.circular(20.0),
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
                                            text:
                                                'Are you sure you want to Approve?',
                                            onCancelBtnTap: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirmBtnTap: () async {
                                              updateStatus(
                                                  id[index],
                                                  'APPROVED',
                                                  'transfer_ownership');
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) {
                                                    return const TransferOwnerList();
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
                              });
                        });
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
}
