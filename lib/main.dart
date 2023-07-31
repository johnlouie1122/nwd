import 'package:flutter/material.dart';
import 'package:nwd/views/admin/admin%20login/login.dart';
import 'package:nwd/views/services%20forms/main.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NWD Customer Service',
      routes: {
        '/adminlogin': (context) => const AdminLogin(),
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
// upload sa github
// 1. git add .
// 2. git commit -m "message"
// 3. git push -u origin main
// flutter build web --web-renderer html

