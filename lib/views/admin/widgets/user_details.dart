import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  Map<String, dynamic>? _userDetails;
  String? _image;
  String? updatedFirstname;

  Map<String, dynamic>? get userDetails => _userDetails;
  String? get image => _image; 

  set userDetails(Map<String, dynamic>? value) {
    _userDetails = value;
    notifyListeners();
  }


  set image(String? newValue) {
    _image = newValue;
    notifyListeners();
  }

  void updateUserDetails(Map<String, dynamic> newDetails) {
    _userDetails = newDetails;
    notifyListeners();
  }
}
