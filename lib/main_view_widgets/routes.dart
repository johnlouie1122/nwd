import 'package:flutter/material.dart';
import 'package:nwd/views/services%20forms/about.dart';
import 'package:nwd/views/services%20forms/announcements.dart';
import 'package:nwd/views/services%20forms/change_water_meter.dart';
import 'package:nwd/views/services%20forms/customer_feedback.dart';
import 'package:nwd/views/services%20forms/disconnection.dart';
import 'package:nwd/views/services%20forms/promo.dart';
import 'package:nwd/views/services%20forms/reconnection.dart';

import 'package:nwd/views/services%20forms/water_meter_calibration.dart';

class RoutesWidget {
  static final routes = {
    '/announcements': (BuildContext context) => const Announcements(),
    '/reconnection': (BuildContext context) => const ReconnectionForm(),
    '/disconnection': (BuildContext context) => const Disconnection(),
    '/water-meter-calibration': (BuildContext context) =>
        const WaterMeterCalibration(),
    '/change-water-meter': (BuildContext context) => const ChangeWaterMeter(),
    '/promo': (BuildContext context) => const Promos(),
    '/about': (BuildContext context) => const AboutUs(),
    '/customer-feedback': (BuildContext context) => const CustomerFeedback(),
  };
}
