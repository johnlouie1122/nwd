import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nwd/views/user/services%20forms/change_water_meter.dart';
import 'package:nwd/views/user/services%20forms/disconnection.dart';

import '../New Water Connection/main applicant/t&c_mainApplicant.dart';
import '../New Water Connection/representative/tc_representative.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
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
              GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth <= 700 ? 3 : 5),
                  children: [
                    _menuCard(FontAwesomeIcons.bullhorn, 'Announcements', printlala),
                    _menuCard(FontAwesomeIcons.tag, 'Promos', printlala),
                    _menuCard(FontAwesomeIcons.message, 'Contact Us', printlala),
                    _menuCard(
                        FontAwesomeIcons.commentDots, 'Customer Feedback', printlala),
                    _menuCard(FontAwesomeIcons.droplet, 'New Water Connection',
                        newWaterConnection),
                    _menuCard(FontAwesomeIcons.handHoldingDroplet,
                        'Transfer of Ownership', printlala),
                    _menuCard(FontAwesomeIcons.dropletSlash,
                        'Voluntary Disconnection Request', voluntaryDisconnection),
                    _menuCard(
                        FontAwesomeIcons.water, 'Water Meter Calibration', printlala),
                    _menuCard(
                        FontAwesomeIcons.arrowsRotate, 'Change Water Meter', changeWater),
                    _menuCard(FontAwesomeIcons.link, 'Reconnection', printlala),
                  ]),
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

  Widget _menuCard(IconData icon, String label, void Function() onTap) =>
      GestureDetector(
          onTap: onTap,
          child: Card(
              elevation: 10,
              shadowColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.blue.shade900, width: 2)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(icon, size: 75, color: Colors.blue),
                        const SizedBox(height: 20),
                        Flexible(
                            child: Text(label,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center))
                      ]))));


  void newWaterConnection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text(
            'Are you a?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
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
                            builder: (BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
  }

  void voluntaryDisconnection () {
    Navigator.push(context, MaterialPageRoute(builder: (builder) {
      return const Disconnection();
    }));
  }
    
    void printlala () {
      print('lala');
    }
  
  void changeWater () {
    showDialog(context: context, builder: (builder) {
      return const ChangeWaterMeter();
    });
  }
}
