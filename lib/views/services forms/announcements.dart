// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';

import 'transfer/transfer_ownership.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  List<Map<String, dynamic>> announcements = [];


  @override
  void initState() {
    super.initState();
    fetchAnnouncements('announcements');
  }

  Future<void> fetchAnnouncements(String tableName) async {
    final response = await http.get(
        Uri.parse('http://localhost/nwd/user-services/fetch.php?table=$tableName'));
    if (response.statusCode == 200) {
      setState(() {
        announcements =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

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
              } else if (value.route == '/transfer-ownership') {
                showDialog(context: context, builder: (BuildContext context) {
                  return const TransferDialog();
                });
              }
            })
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                'Announcements',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        // color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                announcements[index]['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.blue),
                              ),
                              Text(
                                DateFormat('MMMM d, y').format(
                                  DateTime.parse(announcements[index]['date']),
                                ),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                announcements[index]['content'],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void newWaterConnection() {
    showDialog(
      context: context,
      builder: (newWaterConnectionForm) {
        return const ConnectionDialog();
      },
    );
  }
}
