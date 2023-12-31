// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20service%20list/add_promo.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class PromoList extends StatefulWidget {
  const PromoList({super.key});

  @override
  State<PromoList> createState() => _PromoListState();
}

class _PromoListState extends State<PromoList> {
  List<Map<String, dynamic>> promos = [];

  String? currentTitle;
  String? currentContent;

  @override
  void initState() {
    super.initState();
    fetchPromos('promos');
  }

  Future<void> fetchPromos(String tableName) async {
    final response = await http
        .get(Uri.parse('http://localhost/nwd/admin/get_servicelist.php?table=$tableName'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        promos = List<Map<String, dynamic>>.from(data);
      });
    }
  }

  Future<void> deletePromo(String? title) async {
    if (title != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/delete_promo.php'),
        body: {'title': title},
      );
      if (response.statusCode == 200) {
        fetchPromos('promos');
      } else {
        print('Error deleting announcement');
      }
    }
  }

  Future<void> editAnnouncement(String title, String content, String db) async {
    if (currentTitle != null && currentContent != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/update.php'),
        body: {
          'currentTitle': currentTitle!,
          'currentContent': currentContent!,
          'title': title,
          'content': content,
          'db': db,
        },
      );
      if (response.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Announcement Updated Successfully',
          onConfirmBtnTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const PromoList();
                },
              ),
            );
          },
        );
        fetchPromos('promos');
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addPromo,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text(
          'Promos',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: promos.length,
              itemBuilder: (context, index) {
                var tileColor =
                    index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                final promo = promos[index];
                return ListTile(
                  hoverColor: Colors.blue.shade100,
                  tileColor: tileColor,
                  title: Text(
                    promo['title'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: Text(
                    DateFormat('MMMM d, y').format(
                      DateTime.parse(promo['date']),
                    ),
                    style: const TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          content: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'TITLE',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ),
                              ),
                              Text(
                                promo['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'CONTENT',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ),
                              ),
                              Text(
                                promo['content'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  QuickAlert.show(
                                    context: context,
                                    showCancelBtn: true,
                                    confirmBtnText: 'Yes',
                                    type: QuickAlertType.error,
                                    text: 'Are you sure you want to delete?',
                                    onConfirmBtnTap: () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Post successfully deleted!',
                                        onConfirmBtnTap: () async {
                                          if (promo['title'] != null) {
                                            deletePromo(promo['title']);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const PromoList(),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          }
                                        },
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
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String editedTitle = promo['title'];
                                        String editedContent = promo['content'];

                                        currentTitle = promo['title'];
                                        currentContent = promo['content'];
                                        return AlertDialog(
                                          scrollable: true,
                                          content: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'EDIT PROMO',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    editedTitle),
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          hintText: 'TITLE',
                                                        ),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                        onChanged: (value) {
                                                          editedTitle = value;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextField(
                                                        controller:
                                                            TextEditingController(
                                                                text:
                                                                    editedContent),
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          hintText: 'CONTENT',
                                                        ),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                        onChanged: (value) {
                                                          editedContent = value;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            SizedBox(
                                              height: 40,
                                              width: 100,
                                              child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel')),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 100,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    editAnnouncement(
                                                        editedTitle,
                                                        editedContent, 'promos');
                                                  },
                                                  child: const Text(
                                                    'Save',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void addPromo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddAPromo();
        });
  }
}
