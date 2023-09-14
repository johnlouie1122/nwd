// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/services%20forms/main.view.dart';

class Certificate extends StatefulWidget {
  final String code;
  const Certificate({super.key, required this.code});

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  late String generatedCode;

  @override
  void initState() {
    super.initState();
    generatedCode = generateRandomCode();
  }

  String generateRandomCode() {
    var random = Random();
    var code = random.nextInt(90000000) + 10000000;
    return code.toString();
  }

  Future<void> sendCertificateCode() async {
    var url = Uri.parse(
        'http://localhost/nwd/user-services/generate_certificate.php');
    var response = await http.post(url,
        body: {'certificate_code': generatedCode, 'code': widget.code});

    if (response.statusCode == 200) {
      print('Certificate code sent successfully!');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: FittedBox(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/certificate.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Text(
                        generatedCode,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      sendCertificateCode();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const MainView();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
