import 'package:flutter/material.dart';
import 'package:nwd/views/user/services%20forms/customer_feedback.dart';
import 'package:nwd/views/user/services%20forms/change_water_meter.dart';
import 'package:nwd/views/user/services%20forms/disconnection.dart';
import 'package:nwd/views/user/services%20forms/reconnection.dart';
import 'package:nwd/views/user/services%20forms/transfer_ownership.dart';
import 'package:nwd/views/user/services%20forms/water_meter_calibration.dart';

class Home extends StatefulWidget {
  // User's name received from the login page
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const AlertDialog(
          scrollable: true,
          title: Column(
            children: [
              Text('VISION'),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          const Text(
            'SERVICES',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          DropdownButton<String>(
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
                      return const Home();
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
        ],
      ),
    );
  }
}
