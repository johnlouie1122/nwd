import 'package:flutter/material.dart';
import 'package:nwd/views/admin/login.dart';
import 'views/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      routes: {
        '/adminlogin': (context) => const AdminLogin()
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:'nunito', 
      ),
      home: const LoginPage(),
    );
  }
}

// DEBUG
// kini i run kung mag debug gamit web aron makita ang mga images
// flutter run -d chrome --web-renderer html

// BUILD
// kini i run basta mag build ka sa web app
// flutter build web --release
// paghuman ug build, naa ranas "build/web" nga folder sa project
