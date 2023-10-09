// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/footer.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';

import 'transfer/transfer_ownership.dart';

class Promos extends StatefulWidget {
  const Promos({super.key});

  @override
  State<Promos> createState() => _PromosState();
}

class _PromosState extends State<Promos> {
  List<Map<String, dynamic>> promos = [];

  @override
  void initState() {
    super.initState();
    fetchPromos('promos');
  }

  String getImageUrl(String title, String photoName) {
    return 'http://localhost/nwd/uploads/promos/$title/$photoName';
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

  Future<void> fetchPromos(String table) async {
    final response = await http.get(Uri.parse(
        'http://localhost/nwd/admin/get_servicelist.php?table=promos'));
    if (response.statusCode == 200) {
      setState(() {
        promos = List<Map<String, dynamic>>.from(json.decode(response.body));
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
                'PROMOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: promos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      // color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              promos[index]['title'],
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.blue),
                            ),
                            Text(
                              DateFormat('MMMM d, y').format(
                                DateTime.parse(promos[index]['date']),
                              ),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              promos[index]['content'],
                              style: const TextStyle(fontSize: 20),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (promos[index]['photo1'].isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(getImageUrl(
                                              promos[index]['title'],
                                              promos[index]['photo1']));
                                        },
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getImageUrl(
                                                  promos[index]['title'],
                                                  promos[index]['photo1'],
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (promos[index]['photo2'].isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(getImageUrl(
                                              promos[index]['title'],
                                              promos[index]['photo2']));
                                        },
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getImageUrl(
                                                  promos[index]['title'],
                                                  promos[index]['photo2'],
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (promos[index]['photo3'].isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(getImageUrl(
                                              promos[index]['title'],
                                              promos[index]['photo3']));
                                        },
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getImageUrl(
                                                  promos[index]['title'],
                                                  promos[index]['photo3'],
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (promos[index]['photo4'].isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(getImageUrl(
                                              promos[index]['title'],
                                              promos[index]['photo4']));
                                        },
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getImageUrl(
                                                  promos[index]['title'],
                                                  promos[index]['photo4'],
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (promos[index]['photo5'].isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          showFullScreenImage(getImageUrl(
                                              promos[index]['title'],
                                              promos[index]['photo5']));
                                        },
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                getImageUrl(
                                                  promos[index]['title'],
                                                  promos[index]['photo5'],
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
}
