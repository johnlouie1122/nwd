import 'package:flutter/material.dart';
import 'package:nwd/views/homepage/customer_feedback.dart';
import 'package:nwd/views/homepage/services%20forms/applied_service.dart';
import 'package:nwd/views/homepage/services%20forms/disconnection.dart';
import 'package:nwd/views/homepage/services%20forms/reconnection.dart';
import 'package:nwd/views/login/login.dart';

class Home extends StatelessWidget {
  final String userName; // User's name received from the login page
  const Home({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text('Welcome, $userName', style: const TextStyle(fontSize: 20),)),
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
                'SERVICES',
                textAlign: TextAlign.center,
              ),
              ListTile(
                title: const Text('Service Request List'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const AppliedService();
                        },
                      ),
                    );
                },
              ),
              ListTile(
                title: const Text('Transfer of Ownership'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Voluntary Disconnection Request'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Disconnection();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Water Meter Calibration'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Change Water Meter'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Reconnection'),
                onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ReconnectionForm();
                    },
                  ),
                );
                },
              ),
              ListTile(
                title: const Text('Customer Feedback'),
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const CustomerFeedback();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('LOGOUT'),
                onTap: () {
                   Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginPage();
                    },
                  ),
                );
                },
              )
            ],
          ),
        ),
        body: const AlertDialog(
          scrollable: true,
          title: Column(
            children: [
              Text('VISION'),
            ],
          ),
        ));
  }
}
