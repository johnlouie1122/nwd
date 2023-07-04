import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/main%20applicant/t&c_mainApplicant.dart';
import 'package:nwd/views/New%20Water%20Connection/representative/tc_representative.dart';
import '../user/services forms/change_water_meter.dart';
import '../user/services forms/customer_feedback.dart';
import '../user/services forms/disconnection.dart';
import '../user/services forms/reconnection.dart';
import '../user/services forms/transfer_ownership.dart';
import '../user/services forms/water_meter_calibration.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'NWD\n',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade400)),
                          const TextSpan(
                              text: 'Nasipit Water District',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0.5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3))
                            ]),
                        width: 250,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButton<String>(
                            underline: Container(),
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            hint: const Center(
                              child: Text(
                                'Services',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'New Water Connection',
                                child: Text(
                                  'New Water Connection',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'transfer',
                                child: Text(
                                  'Transfer of Ownership',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'disconnection',
                                child: Text(
                                  'Voluntary Disconnection Request',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'calibration',
                                child: Text(
                                  'Water Meter Calibration',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'changeMeter',
                                child: Text(
                                  'Change Water Meter',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'reconnection',
                                child: Text(
                                  'Reconnection',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'feedback',
                                child: Text(
                                  'Customer Feedback',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            onChanged: (String? value) {
                              if (value == 'New Water Connection') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text(
                                        'Are you a?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return const TermsAndConditionsMainApplicant();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.person,
                                                    size: 80,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return const TermsAndConditionsRepresentative();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.person_add_alt_1,
                                                    size: 80,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Main Applicant'),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Text('Representative'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (value == 'transfer') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const TransferOfOwnership();
                                    },
                                  ),
                                );
                              } else if (value == 'disconnection') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const Disconnection();
                                    },
                                  ),
                                );
                              } else if (value == 'calibration') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const WaterMeterCalibration();
                                    },
                                  ),
                                );
                              } else if (value == 'changeMeter') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const ChangeWaterMeter();
                                    },
                                  ),
                                );
                              } else if (value == 'reconnection') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const ReconnectionForm();
                                    },
                                  ),
                                );
                              } else if (value == 'feedback') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const CustomerFeedback();
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0.5,
                                  blurRadius: 3,
                                  offset: Offset(0, 3))
                            ]),
                        width: 250,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButton<String>(
                            underline: Container(),
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.white,
                            ),
                            hint: const Center(
                              child: Text(
                                'Announcements and offers',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'home',
                                child: Text(
                                  'Home',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'transfer',
                                child: Text(
                                  'Transfer of Ownership',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'disconnection',
                                child: Text(
                                  'Voluntary Disconnection Request',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'calibration',
                                child: Text(
                                  'Water Meter Calibration',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'changeMeter',
                                child: Text(
                                  'Change Water Meter',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'reconnection',
                                child: Text(
                                  'Reconnection',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'feedback',
                                child: Text(
                                  'Customer Feedback',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            onChanged: (String? value) {
                              if (value == 'home') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const Test();
                                    },
                                  ),
                                );
                              } else if (value == 'transfer') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const TransferOfOwnership();
                                    },
                                  ),
                                );
                              } else if (value == 'disconnection') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const Disconnection();
                                    },
                                  ),
                                );
                              } else if (value == 'calibration') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const WaterMeterCalibration();
                                    },
                                  ),
                                );
                              } else if (value == 'changeMeter') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const ChangeWaterMeter();
                                    },
                                  ),
                                );
                              } else if (value == 'reconnection') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const ReconnectionForm();
                                    },
                                  ),
                                );
                              } else if (value == 'feedback') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const CustomerFeedback();
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20.0))),
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blueAccent, Colors.blue.shade200]),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
