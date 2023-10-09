// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  TextEditingController declineReasonController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void showFullScreenImage(String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Hero(
                tag: imageUrl,
                child: Image.network(imageUrl),
              ),
            ),
          );
        },
      ),
    );
  }

  String getImageUrl(String oldName, String imageName) {
    return 'http://localhost/nwd/uploads/$oldName/$imageName';
  }

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
  List<String> waiver = [];
  List<String> waterpermit = [];
  List<String> lotTitle = [];
  List<String> validId = [];
  List<String> brgyCert = [];
  List<String> auth = [];
  List<String> validIdRep = [];

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
    Uri url = Uri.parse('http://localhost/nwd/admin/new_water.php');
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
      List<String> waiverData = [];
      List<String> waterpermitData = [];
      List<String> lotTitleData = [];
      List<String> validIdData = [];
      List<String> brgyCertData = [];
      List<String> authData = [];
      List<String> validIdRepData = [];

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
        waiverData.add(data['waiver']);
        waterpermitData.add(data['water_permit']);
        lotTitleData.add(data['lot_title']);
        validIdData.add(data['valid_id']);
        brgyCertData.add(data['brgy_certificate']);
        authData.add(data['authorization']);
        validIdRepData.add(data['valid_id_representative']);
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
        waiver = waiverData;
        waterpermit = waterpermitData;
        lotTitle = lotTitleData;
        validId = validIdData;
        brgyCert = brgyCertData;
        auth = authData;
        validIdRep = validIdRepData;
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
            return const TestHome();
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
                                              Text(name[index],
                                                  textAlign: TextAlign.center),
                                              Text(address[index],
                                                  textAlign: TextAlign.center),
                                              Text(contactNumber[index],
                                                  textAlign: TextAlign.center),
                                              Text(landmark[index],
                                                  textAlign: TextAlign.center),
                                              Text(
                                                nearestExistingCustomer[index],
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(type[index],
                                                  textAlign: TextAlign.center),
                                              Text(orientationStatus[index],
                                                  textAlign: TextAlign.center),
                                              Text(certificateCode[index],
                                                  textAlign: TextAlign.center),
                                            ])
                                          ],
                                        ),
                                        SizedBox(
                                            height: 10,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (waiver[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          waiver[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
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
                                            if (waterpermit[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          waterpermit[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          waterpermit[index],
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
                                            if (lotTitle[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          lotTitle[index]));
                                                },
                                                child: Container(
                                                  
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          lotTitle[index],
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
                                            if (validId[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          validId[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          validId[index],
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
                                            if (brgyCert[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          brgyCert[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          brgyCert[index],
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
                                            if (auth[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          auth[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          auth[index],
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
                                            if (validIdRep[index].isNotEmpty)
                                              GestureDetector(
                                                onTap: () {
                                                  showFullScreenImage(
                                                      getImageUrl(name[index],
                                                          validIdRep[index]));
                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        getImageUrl(
                                                          name[index],
                                                          validIdRep[index],
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
                                    const SizedBox(height: 20),
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
                                              return const TestHome();
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
                                          onConfirmBtnTap: () {},
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
                                          onConfirmBtnTap: () {},
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
                                          onConfirmBtnTap: () {},
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
                                          onConfirmBtnTap: () {},
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
                                          onConfirmBtnTap: () {},
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

  String rr(String text) => text.replaceAll(' ', '%20');

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
