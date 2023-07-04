import 'package:flutter/material.dart';
import 'package:nwd/views/user/homepage/homepage.dart';

class WaterMeterCalibration extends StatefulWidget {
  
  const WaterMeterCalibration({super.key});

  @override
  State<WaterMeterCalibration> createState() => _WaterMeterCalibrationState();
}

class _WaterMeterCalibrationState extends State<WaterMeterCalibration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text('Water Meter Calibration')),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const AlertDialog(
          scrollable: true,
          content: Center(
            child: Column(
              children: [
                Text('Water Meter Calibration Request Form')
              ],
            ),
          ),
        ),
      ),
    );
  }
}