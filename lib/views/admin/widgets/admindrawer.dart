import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20service%20list/announcement_list.dart';
import 'package:nwd/views/admin/admin%20service%20list/customer_feedback_list.dart';
import 'package:nwd/views/admin/admin%20service%20list/pending_service_list.dart';
import 'package:nwd/views/admin/admin%20login/login.dart';
import 'package:nwd/views/admin/admin%20service%20list/promo_list.dart';
import 'package:nwd/views/admin/homepage/adminpage.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
            'MENU',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
           ListTile(
            title: const Text('New Water Service Applicant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
            title: const Text('Pending Service List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const PendingServiceList();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Customer Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
            title: const Text('Announcements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
            title: const Text('Promos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
            title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
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
