import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/views/services%20forms/change_water_meter.dart';
import 'package:nwd/views/services%20forms/disconnection.dart';
import 'package:nwd/views/services%20forms/reconnection.dart';
import 'package:nwd/views/services%20forms/transfer_ownership.dart';
import 'package:nwd/views/services%20forms/water_meter_calibration.dart';

class ServiceDialog extends StatefulWidget {
  const ServiceDialog({Key? key}) : super(key: key);

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'ONLINE SERVICES',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Center(
          child: Column(children: [
        ListTile(
          title: const Text(
            'New Water Connection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ConnectionDialog();
                });
          },
        ),
        ListTile(
          title: const Text(
            'Reconnection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ReconnectionForm();
                });
          },
        ),
        ListTile(
          title: const Text(
            'Disconnection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Disconnection();
                });
          },
        ),
        ListTile(
          title: const Text(
            'Water Meter Calibration',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const WaterMeterCalibration();
                });
          },
        ),
        ListTile(
          title: const Text(
            'Change Water Meter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ChangeWaterMeter();
                });
          },
        ),
        ListTile(
          title: const Text(
            'Transfer of Ownership',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const TransferOfOwnership();
                });
          },
        ),
      ])),
    );
  }
}
