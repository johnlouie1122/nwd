import 'package:flutter/material.dart';
import 'package:nwd/main_view_widgets/dialog.dart';
import 'package:nwd/views/services%20forms/transfer/transfer_ownership.dart';
import 'package:nwd/views/services%20forms/change_water_meter.dart';
import 'package:nwd/views/services%20forms/disconnection.dart';
import 'package:nwd/views/services%20forms/reconnection.dart';
import 'package:nwd/views/services%20forms/water_meter_calibration.dart';

void handleMenuNavigation(BuildContext context, String value) {
  if (value == 'New Water Connection') {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConnectionDialog();
      },
    );
  } else if (value == 'Reconnection') {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const ReconnectionForm();
        },
      ),
      (Route<dynamic> route) => false,
    );
  } else if (value == 'Change Water Meter') {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const ChangeWaterMeter();
        },
      ),
      (Route<dynamic> route) => false,
    );
  } else if (value == 'Disconnection') {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Disconnection();
        },
      ),
      (Route<dynamic> route) => false,
    );
  } else if (value == 'Transfer Ownership') {
   showDialog(context: context, builder: (BuildContext context) {
    return const TransferDialog();
   });
  } else if (value == 'Meter Calibration') {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const WaterMeterCalibration();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }
}
