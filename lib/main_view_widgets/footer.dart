import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Developed by: Christoper Rom | Seanphen Palao | John Louie Abobo',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
