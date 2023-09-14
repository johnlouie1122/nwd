import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20login/login.dart';
import 'package:nwd/views/admin/widgets/user_details.dart';
import 'package:nwd/views/services%20forms/about.dart';
import 'package:nwd/views/services%20forms/announcements.dart';
import 'package:nwd/views/services%20forms/change_water_meter.dart';
import 'package:nwd/views/services%20forms/customer_feedback.dart';
import 'package:nwd/views/services%20forms/disconnection.dart';
import 'package:nwd/views/services%20forms/main.view.dart';
import 'package:nwd/views/services%20forms/promo.dart';
import 'package:nwd/views/services%20forms/reconnection.dart';
import 'package:nwd/views/services%20forms/transfer_ownership.dart';
import 'package:nwd/views/services%20forms/water_meter_calibration.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NWD Customer Service',
      routes: {
        '/adminlogin': (context) => const AdminLogin(),
        '/announcements': (BuildContext context) => const Announcements(),
        '/reconnection': (BuildContext context) => const ReconnectionForm(),
        '/disconnection': (BuildContext context) => const Disconnection(),
        '/transfer-ownership': (BuildContext context) =>
            const TransferOfOwnership(),
        '/water-meter-calibration': (BuildContext context) =>
            const WaterMeterCalibration(),
        '/change-water-meter': (BuildContext context) =>
            const ChangeWaterMeter(),
        '/promo': (BuildContext context) => const Promos(),
        '/about': (BuildContext context) => const AboutUs(),
        '/customer-feedback': (BuildContext context) =>
            const CustomerFeedback(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainView(),
    );
  }
}

// DEBUG
// kini i run kung mag debug gamit web aron makita ang mga images
// flutter run -d chrome --web-renderer html
// ==================================================
// BUILD
// kini i run basta mag build ka sa web app
// flutter build web --release

// paghuman ug build, naa ranas "build/web" nga folder sa project, ideploy dayon sa firebase hosting
// firebase deploy
// ==================================================
// github push
// 1. git add .
// 2. git commit -m "message"
// 3. git push -u origin main
// flutter build web --web-renderer html

