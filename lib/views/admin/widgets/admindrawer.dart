import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20service%20list/calibration.dart';
import 'package:nwd/views/admin/admin%20service%20list/change_meter.dart';
import 'package:nwd/views/admin/admin%20service%20list/disconnection.dart';
import 'package:nwd/views/admin/admin%20service%20list/edit_profile.dart';
import 'package:nwd/views/admin/admin%20service%20list/reconnection.dart';
import 'package:nwd/views/admin/admin%20service%20list/transfer_ownership.dart';
import 'package:nwd/views/admin/admin%20service%20list/user_list.dart';
import 'package:nwd/views/admin/admin%20service%20list/announcement_list.dart';
import 'package:nwd/views/admin/admin%20service%20list/customer_feedback_list.dart';
import 'package:nwd/views/admin/admin%20login/login.dart';
import 'package:nwd/views/admin/admin%20service%20list/promo_list.dart';
import 'package:nwd/views/admin/homepage/adminpage.dart';
import 'package:nwd/views/admin/widgets/user_details.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String selectedValue = 'Service List';

  @override
  Widget build(BuildContext context) {
    var userDetailsProvider = Provider.of<UserProvider>(context);
    var userDetails = userDetailsProvider.userDetails;

    var firstName = userDetails?['firstName'];
    var role = userDetails?['role'];
    var image = userDetails?['image'];
    var username = userDetails?['username'];

    var imageUrl = 'http://localhost/nwd/admin/uploads/$username/$image';

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1))
                  ]),
                  child: CircleAvatar(
                      radius: 50, backgroundImage: NetworkImage(imageUrl)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$firstName',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '($role)',
                      style: const TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const EditUser();
                          },
                        );
                      },
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Text(
            'MENU',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
          ListTile(
            title: const Text(
              'New Water Service Applicant',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AdminHomePage();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedValue = newValue;
                        });
                        if (newValue == 'Service List') {
                        } else if (newValue == 'Reconnection') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const ReconnectionList();
                          }), (route) => false);
                        } else if (newValue == 'Disconnection') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const DisconnectionList();
                          }), (route) => false);
                        } else if (newValue == 'Transfer of Ownership') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const TransferOwnerLst();
                          }), (route) => false);
                        } else if (newValue == 'Meter Calibration') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const CalibrationList();
                          }), (route) => false);
                        } else if (newValue == 'Change Water Meter') {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const ChangeMeterList();
                          }), (route) => false);
                        }
                      }
                    },
                    items: <String>[
                      'Service List',
                      'Reconnection',
                      'Disconnection',
                      'Transfer of Ownership',
                      'Meter Calibration',
                      'Change Water Meter',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 17)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Customer Feedback',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const CustomerFeedbackList();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'User Accounts List',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const UserAccounts();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Announcements',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AnnouncementList();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Promos',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const PromoList();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => const AdminLogin(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
