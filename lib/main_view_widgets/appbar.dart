import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/appbar_routes.dart';
import 'package:nwd/views/services%20forms/about.dart';
import 'package:nwd/views/services%20forms/announcements.dart';
import 'package:nwd/views/services%20forms/customer_feedback.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:nwd/views/services%20forms/promo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isNarrowScreen;

  const CustomAppBar({
    super.key,
    required this.isNarrowScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isNarrowScreen
          ? TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MainView();
                    },
                  ),
                );
              },
              child: const Text(
                'NWD',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            )
          : SizedBox(
              height: 60,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MainView();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
      actions: isNarrowScreen
          ? [
              const SizedBox(
                height: 60,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ]
          : [
              ButtonBar(
                children: [
                  PopupMenuButton<String>(
                    icon: null,
                    onSelected: (value) {
                      handleMenuNavigation(context, value);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'New Water Connection',
                        child: Text(
                          'New Water Connection',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem<String>(
                        value: 'Reconnection',
                        child: Text(
                          'Reconnection',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Disconnection',
                        child: Text(
                          'Disconnection',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Transfer Ownership',
                        child: Text(
                          'Transfer Ownership',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Meter Calibration',
                        child: Text(
                          'Meter Calibration',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Change Water Meter',
                        child: Text(
                          'Change Water Meter',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                    ],
                    child: Text(
                      'ONLINE SERVICES',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Announcements();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'ANNOUNCEMENTS',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Promos();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'PROMOS',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const AboutUs();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'ABOUT US',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const CustomerFeedback();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'CUSTOMER FEEDBACK',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(isNarrowScreen ? kToolbarHeight : 60);
}
