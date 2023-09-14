// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nwd/views/admin/admin%20service%20list/user_list.dart';
import 'package:quickalert/quickalert.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String _selectedRole = 'admin';
  String _otherRole = '';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Add User Account',
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 2),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Last Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          const Text('Select Role:'),
          DropdownButton<String>(
            value: _selectedRole,
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue!;
              });
            },
            items: <String>['admin', 'superadmin', 'other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(child: Text(value)),
                ),
              );
            }).toList(),
          ),
          if (_selectedRole == 'other')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Specify role'),
                    onChanged: (value) {
                      setState(() {
                        _otherRole = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://localhost/nwd/admin/add_user.php'),
                    body: {
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                      'username': usernameController.text,
                      'password': passwordController.text,
                      'role':
                          _selectedRole == 'other' ? _otherRole : _selectedRole,
                    },
                  );

                  if (response.statusCode == 200) {
                    QuickAlert.show(
                      context: context,
                      onConfirmBtnTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const UserAccounts();
                          },
                        ));
                      },
                      type: QuickAlertType.success,
                      text: 'Account successfully added',
                    );
                  } else {
                    QuickAlert.show(
                      context: context,
                      onConfirmBtnTap: () {
                        Navigator.of(context).pop();
                      },
                      type: QuickAlertType.error,
                      text: 'An error has occured',
                    );
                  }
                },
                child: const Text(
                  'Add Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
