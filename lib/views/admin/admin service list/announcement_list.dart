// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/admin%20service%20list/add_announcement.dart';
import 'package:nwd/views/admin/widgets/admindrawer.dart';
import 'package:quickalert/quickalert.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({super.key});

  @override
  State<AnnouncementList> createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  List<Map<String, dynamic>> announcements = [];

  String? currentTitle;
  String? currentContent;

  @override
  void initState() {
    super.initState();
    fetchAnnouncements('announcements');
  }

  Future<void> fetchAnnouncements(String tableName) async {
    final response = await http
        .get(Uri.parse('http://localhost/nwd/admin/get_servicelist.php?table=$tableName'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        announcements = List<Map<String, dynamic>>.from(data);
      });
    }
  }

  Future<void> deleteAnnouncement(String? title) async {
    if (title != null) {
      final response = await http.post(
        Uri.parse('http://localhost/nwd/admin/delete_announcement.php'),
        body: {'title': title},
      );
      if (response.statusCode == 200) {
        fetchAnnouncements('announcements');
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
                  return const AnnouncementList();
                },
              ),
            );
          },
        );
        fetchAnnouncements('announcements');
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
        onPressed: addAnnouncement,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                var tileColor =
                    index % 2 == 0 ? Colors.white : Colors.grey.shade100;
                final announcement = announcements[index];
                return ListTile(
                  hoverColor: Colors.blue.shade100,
                  tileColor: tileColor,
                  title: Text(
                    announcement['title'],
                    style: const TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'TITLE',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Text(
                                announcement['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 25),
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
                                announcement['content'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 25),
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
                                    title: 'Confirmation . . . ',
                                    text: 'Are you sure you want to delete?',
                                    onConfirmBtnTap: () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: 'Post successfully deleted!',
                                        onConfirmBtnTap: () async {
                                          if (announcement['title'] != null) {
                                            deleteAnnouncement(
                                                announcement['title']);
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const AnnouncementList(),
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
                                        String editedTitle =
                                            announcement['title'];
                                        String editedContent =
                                            announcement['content'];

                                        currentTitle = announcement['title'];
                                        currentContent =
                                            announcement['content'];
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
                                                  'Edit Announcement',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: 50,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: editedTitle),
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      labelText: 'TITLE',
                                                    ),
                                                    onChanged: (value) {
                                                      editedTitle = value;
                                                    },
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
                                                    child: TextField(
                                                      controller:
                                                          TextEditingController(
                                                              text:
                                                                  editedContent),
                                                      maxLines: null,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        labelText: 'CONTENT',
                                                      ),
                                                      onChanged: (value) {
                                                        editedContent = value;
                                                      },
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
                                                  child: const Text(
                                                    'Cancel',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
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
                                                        editedContent, 'announcements');
                                                  },
                                                  child: const Text(
                                                    'Save',
                                                    textAlign: TextAlign.center,
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
                                  textAlign: TextAlign.center,
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

  void addAnnouncement() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddAnnouncement();
        });
  }
}
