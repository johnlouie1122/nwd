// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController declineReasonController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredServiceData = [];
  List<dynamic> serviceData = [];

  // final twilioFlutter = TwilioFlutter(
  //   accountSid: 'AC99e89e20dfaa62ca55f82d16ec644a81',
  //   authToken: '36e8bd7cfde18101d667db6e69b25212',
  //   twilioNumber: '+13083368459',
  // );

  @override
  void initState() {
    super.initState();
    fetchServiceData();
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

  String getImageUrl(String name, String imageName) {
    return 'http://localhost/nwd/uploads/$name/$imageName';
  }

  Future<void> fetchServiceData() async {
    final response = await http.get(Uri.parse(
        'http://localhost/nwd/admin/get_servicelist.php?table=registration'));
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
            .where((service) =>
                service['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredServiceData = List.from(serviceData);
      });
    }
  }

  Future<void> updateApplicantStatus(String name, String status, int index,
      String type, String declineReason) async {
    Random random = Random();
    int randomNumber = random.nextInt(900000) + 100000;
    Uri url =
        Uri.parse('http://localhost/nwd/admin/update_applicant_status.php');
    final response = await http.post(url, body: {
      'name': name,
      'status': status,
      'randomNumber': randomNumber.toString(),
    });

    if (response.statusCode == 200) {
      // if (status == 'FOR EVALUATION') {
      //   await twilioFlutter.sendSMS(
      //     messageBody:
      //         'Nasipit Water District: Your online new water connection is now set for Evaluation. Here is your step 2 code: $randomNumber. Use this code if you already have all the requirements for step 2',
      //     toNumber: contactNumber,
      //   );
      // } else if (status == 'DECLINED') {
      //   await twilioFlutter.sendSMS(
      //     messageBody:
      //         'Nasipit Water District: We regret to inform you that your request for a new water connection has been declined. Reason: $declineReason',
      //     toNumber: contactNumber,
      //   );
      // } else if (status == 'APPROVED') {
      //   await twilioFlutter.sendSMS(
      //     messageBody:
      //         'Nasipit Water District: Congratulations! Your request for a new water connection has been approved. Please submit a copy of your submitted details and pay the new water connection fees at the Nasipit Water District office. Thank you!',
      //     toNumber: contactNumber,
      //   );
      // } else if (status == 'ORIENTATION') {
      //   await twilioFlutter.sendSMS(
      //     messageBody:
      //         'Nasipit Water District: Your Online new water connection is now set for Orientation, here is your orientation code: $randomNumber',
      //     toNumber: contactNumber,
      //   );
      // }

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
                        onChanged: filterSearchResults,
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
                  itemCount: filteredServiceData.length,
                  itemBuilder: (context, index) {
                    var tileColor =
                        index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                    final service = filteredServiceData[index];
                    // final id = service['id'];
                    final name = service['name'];
                    final address = service['address'];
                    final contact = service['contact_number'];
                    final landmark = service['landmark'];
                    final nearestExistingCustomer =
                        service['nearest_existing_customer'];
                    final waterPermit = service['water_permit'];
                    final waiver = service['waiver'];
                    final lotTitle = service['lot_title'];
                    final validId = service['valid_id'];
                    final brgyCert = service['brgy_certificate'];
                    final auth = service['authorization'];
                    final validIdRep = service['valid_id_representative'];
                    final certCode = service['certificate_code'];
                    final status = service['status'];
                    final orientationStatus = service['orientation_status'];
                    final type = service['type'];

                    return ListTile(
                        hoverColor: Colors.blue.shade100,
                        tileColor: tileColor,
                        title: Text(
                          name,
                          style: const TextStyle(fontSize: 15),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10))),
                                              children: [
                                                TableCell(
                                                  child: Text(
                                                    'NAME',
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
                                                    'CONTACT NUMBER',
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
                                                    'NEAREST EXISTING CUSTOMER',
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
                                                    'ORIENTATION STATUS',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Text(
                                                    'CERTIFICATE CODE',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(children: [
                                              Text(name,
                                                  textAlign: TextAlign.center),
                                              Text(address,
                                                  textAlign: TextAlign.center),
                                              Text(contact,
                                                  textAlign: TextAlign.center),
                                              Text(landmark,
                                                  textAlign: TextAlign.center),
                                              Text(
                                                nearestExistingCustomer,
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(type,
                                                  textAlign: TextAlign.center),
                                              Text(orientationStatus,
                                                  textAlign: TextAlign.center),
                                              Text(certCode,
                                                  textAlign: TextAlign.center),
                                            ])
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (waiver.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(
                                                  getImageUrl(name, waiver));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      waiver,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Waiver',
                                                      style: TextStyle(
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
                                        const SizedBox(width: 10),
                                        if (waterPermit.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(getImageUrl(
                                                  name, waterPermit));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      waterPermit,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Water Permit',
                                                      style: TextStyle(
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
                                        const SizedBox(width: 10),
                                        if (lotTitle.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(
                                                  getImageUrl(name, lotTitle));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      lotTitle,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Lot Title',
                                                      style: TextStyle(
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
                                        const SizedBox(width: 10),
                                        if (validId.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(
                                                  getImageUrl(name, validId));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      validId,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Valid ID',
                                                      style: TextStyle(
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
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (brgyCert.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(
                                                  getImageUrl(name, brgyCert));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      brgyCert,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Brgy. Certificate',
                                                      style: TextStyle(
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
                                        if (auth.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(
                                                  getImageUrl(name, auth));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      auth,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Authorization',
                                                      style: TextStyle(
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
                                        if (validIdRep.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              showFullScreenImage(getImageUrl(
                                                  name, validIdRep));
                                            },
                                            child: Container(
                                              height: 300,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    getImageUrl(
                                                      name,
                                                      validIdRep,
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.dstATop,
                                                  ),
                                                ),
                                              ),
                                              child: const Stack(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Valid ID (REPRESENTATIVE)',
                                                      style: TextStyle(
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
                                          onConfirmBtnTap: () async {
                                            await deleteApplicant(name);
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
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
                                            controller: declineReasonController,
                                            decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelText: 'Reason for declining',
                                            ),
                                          ),
                                          onCancelBtnTap: () {
                                            Navigator.pop(context);
                                          },
                                          onConfirmBtnTap: () async {
                                            String declineReason =
                                                declineReasonController.text;
                                            await updateApplicantStatus(
                                                name,
                                                'DECLINED',
                                                index,
                                                type,
                                                declineReason);
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                                name,
                                                'FOR EVALUATION',
                                                index,
                                                type,
                                                '');
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
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
                                            await updateApplicantStatus(name,
                                                'ORIENTATION', index, type, '');
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
                                            await updateApplicantStatus(name,
                                                'APPROVED', index, type, '');
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
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
}
