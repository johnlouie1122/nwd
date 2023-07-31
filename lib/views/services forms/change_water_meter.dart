// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'dart:html' as html;

class ChangeWaterMeter extends StatefulWidget {
  const ChangeWaterMeter({super.key});

  @override
  State<ChangeWaterMeter> createState() => _ChangeWaterMeterState();
}

class _ChangeWaterMeterState extends State<ChangeWaterMeter> {
  void _openWebsiteURL(String url) {
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isNarrowScreen = screenWidth <= 800;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          _openWebsiteURL('https://www.facebook.com/nwdcustservice/');
        },
        child: const Image(
          image: AssetImage('assets/images/messenger.png'),
        ),
      ),
      appBar: CustomAppBar(isNarrowScreen: isNarrowScreen),
      drawer: isNarrowScreen || screenWidth == 800
          ? CustomDrawer(onMenuSelected: (value) {
              if (RoutesWidget.routes.containsKey(value.route)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: RoutesWidget.routes[value.route]!,
                  ),
                );
              } else if (value.route == '/new-water-connection') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ConnectionDialog();
                    });
              }
            })
          : null,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Change Water Meter',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
