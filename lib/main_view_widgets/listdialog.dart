import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/views/services%20forms/transfer/transfer_ownership.dart';
import 'package:nwd/views/services%20forms/change_water_meter.dart';
import 'package:nwd/views/services%20forms/disconnection.dart';
import 'package:nwd/views/services%20forms/reconnection.dart';
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
        'List of Online Services',
        textAlign: TextAlign.center,
      ),
      content: Center(
        child: Column(children: [
          ListTile(
            title: const Text('New Water Connection'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ConnectionDialog();
                  });
            },
          ),
          ListTile(
            title: const Text('Reconnection'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const ReconnectionForm();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Disconnection'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Disconnection();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Water Meter Calibration'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const WaterMeterCalibration();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Change Water Meter'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const ChangeWaterMeter();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Transfer of Ownership'),
            onTap: () {
             showDialog(context: context, builder: (BuildContext context) {
              return const TransferDialog();
             });
            },
          ),
        ]),
      ),
    );
  }
}
