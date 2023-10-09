// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/footer.dart';
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

  String getImageUrl(String title, String photoName) {
    return 'http://localhost/nwd/uploads/announcements/$title/$photoName';
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

  Future<void> fetchAnnouncements(String tableName) async {
    final response = await http.get(Uri.parse(
        'http://localhost/nwd/admin/get_servicelist.php?table=announcements'));
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
      backgroundColor: const Color.fromARGB(255, 231, 227, 227),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
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
                'ANNOUNCEMENTS',
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
                    width: 950,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                              SizedBox(
                                width: 900,
                                child: Text(
                                  announcements[index]['content'],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (announcements[index]['photo1']
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            showFullScreenImage(getImageUrl(
                                                announcements[index]['title'],
                                                announcements[index]
                                                    ['photo1']));
                                          },
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getImageUrl(
                                                    announcements[index]
                                                        ['title'],
                                                    announcements[index]
                                                        ['photo1'],
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (announcements[index]['photo2']
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            showFullScreenImage(getImageUrl(
                                                announcements[index]['title'],
                                                announcements[index]
                                                    ['photo2']));
                                          },
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getImageUrl(
                                                    announcements[index]
                                                        ['title'],
                                                    announcements[index]
                                                        ['photo2'],
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (announcements[index]['photo3']
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            showFullScreenImage(getImageUrl(
                                                announcements[index]['title'],
                                                announcements[index]
                                                    ['photo3']));
                                          },
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getImageUrl(
                                                    announcements[index]
                                                        ['title'],
                                                    announcements[index]
                                                        ['photo3'],
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (announcements[index]['photo4']
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            showFullScreenImage(getImageUrl(
                                                announcements[index]['title'],
                                                announcements[index]
                                                    ['photo4']));
                                          },
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getImageUrl(
                                                    announcements[index]
                                                        ['title'],
                                                    announcements[index]
                                                        ['photo4'],
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (announcements[index]['photo5']
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            showFullScreenImage(getImageUrl(
                                                announcements[index]['title'],
                                                announcements[index]
                                                    ['photo5']));
                                          },
                                          child: Container(
                                            height: 300,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  getImageUrl(
                                                    announcements[index]
                                                        ['title'],
                                                    announcements[index]
                                                        ['photo5'],
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Footer(),
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
