import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:nwd/main_view_widgets/appbar.dart';
import 'package:nwd/main_view_widgets/card_widget.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/main_view_widgets/footer.dart';
import 'package:nwd/main_view_widgets/listdialog.dart';
import 'package:nwd/main_view_widgets/routes.dart';
import 'package:nwd/main_view_widgets/sidebar.dart';
import 'package:nwd/views/services%20forms/transfer/transfer_ownership.dart';
import 'package:nwd/views/services%20forms/about.dart';
import 'package:nwd/views/services%20forms/announcements.dart';
import 'package:nwd/views/services%20forms/customer_feedback.dart';
import 'package:nwd/views/services%20forms/promo.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Safe and potable water',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Nasipit Water District',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue),
                        ),
                        Text(
                          'WATER IS LIFE, SAVE IT',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CustomCard(
                        color: Colors.blue,
                        title: 'Announcements',
                        description:
                            'Stay connected and never miss a drop of vital information. Follow us on social media, and visit our website regularly to catch the tide of exciting news.',
                        buttonText: 'Take me there',
                        imagePath: 'assets/images/speaker.png',
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const Announcements();
                          }), (route) => false);
                        }),
                    CustomCard(
                        color: Colors.amber,
                        title: 'Promos',
                        description:
                            'Discover a world of possibilities without stretching your budget. These promotions are crafted with your satisfaction in mind, ensuring you receive the best value for your investment.',
                        buttonText: 'Take me there',
                        imagePath: 'assets/images/promos.png',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Promos();
                              },
                            ),
                          );
                        }),
                    CustomCard(
                        color: Colors.cyan,
                        title: 'Online Services',
                        description:
                            'Select one of our Online Serivces to embark on a seamless journey towards accessing our top-notch services, all from the comfort of your home. Embrace convenience like never before!',
                        buttonText: 'Take me there',
                        imagePath: 'assets/images/services.png',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ServiceDialog();
                              });
                        }),
                    CustomCard(
                        color: Colors.amber,
                        title: 'About us',
                        description:
                            'Get to Know Us Better! Unveiling the Heart of Our Company and What Drives Us Forward. Explore Our Story, Values, and Commitment to Excellence.',
                        buttonText: 'Take me there',
                        imagePath: 'assets/images/us.png',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const AboutUs();
                          }));
                        }),
                    CustomCard(
                        color: Colors.cyan,
                        title: 'Customer Feedback',
                        description:
                            'Help Us Improve by Sharing Your Experience, Let your voice be heard. Your Insights Fuel Our Progress and Ensure Top-notch Service. Together, Share Your Feedback and Shape a Better Water Connection Experience!',
                        buttonText: 'Take me there',
                        imagePath: 'assets/images/feedback.png',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const CustomerFeedback();
                          }));
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
