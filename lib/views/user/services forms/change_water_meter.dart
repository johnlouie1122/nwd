import 'package:flutter/material.dart';
class ChangeWaterMeter extends StatefulWidget {

  const ChangeWaterMeter({super.key});

  @override
  State<ChangeWaterMeter> createState() => _ChangeWaterMeterState();
}

class _ChangeWaterMeterState extends State<ChangeWaterMeter> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          scrollable: true,
          content: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Text('Change Water Meter')
              ],
            ),
          ),
        );
  }
}