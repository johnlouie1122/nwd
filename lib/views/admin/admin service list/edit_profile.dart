// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nwd/views/admin/homepage/adminpage.dart';
import 'package:nwd/views/admin/widgets/user_details.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends State<EditUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? waterpermit;
  List<int>? waterpermitbyte;
  List<int>? updatedImageBytes;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userDetailsProvider, child) {
        var userDetails = userDetailsProvider.userDetails;
        var role = userDetails?['role'];
        var username = userDetails?['username'];
        var image = userDetails?['image'];
        var imageUrl = 'http://localhost/nwd/admin/uploads/$username/$image';
        firstNameController.text = userDetails?['firstName'] ?? '';
        lastNameController.text = userDetails?['lastName'] ?? '';
        usernameController.text = userDetails?['username'] ?? '';
        passwordController.text = userDetails?['password'] ?? '';

        Future<void> chooseFile1() async {
          final result =
              await FilePicker.platform.pickFiles(type: FileType.image);

          if (result != null) {
            setState(() {
              waterpermit = result.files.single.name;
              waterpermitbyte = result.files.single.bytes;

              updatedImageBytes = waterpermitbyte;
            });
          }
        }

        Future<void> submitFile() async {
          final waterpermitName = waterpermit ?? '$image';
          final request = http.MultipartRequest(
            'POST',
            Uri.parse('http://localhost/nwd/admin/update_profile.php'),
          );
          request.fields['firstName'] = firstNameController.text;
          request.fields['lastName'] = lastNameController.text;
          request.fields['username'] = usernameController.text;
          request.fields['password'] = passwordController.text;
          request.fields['imageName'] = waterpermitName;

          if (waterpermitbyte != null) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'file1',
                waterpermitbyte!,
                filename: waterpermitName,
                contentType: MediaType('application', 'octet-stream'),
              ),
            );
          }

          final response = await request.send();
          if (response.statusCode == 200) {
            QuickAlert.show(
              barrierDismissible: false,
              context: context,
              title: 'Application Submitted!',
              onConfirmBtnTap: () {
                var userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.image = waterpermitName;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const AdminHomePage();
                }), (route) => false);
              },
              type: QuickAlertType.success,
              text: 'Profile Saved Successfully!',
            );
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error...',
              text: 'Failed to Change Profile',
            );
          }
        }

        Widget fileButton(
            String? fileName, String buttonText, VoidCallback onPressed) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    fileName == null ? buttonText : '$buttonText ($fileName)',
                    style: TextStyle(
                      color: fileName != null ? Colors.black : Colors.grey,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(Icons.camera_alt_rounded,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          );
        }

        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            if (updatedImageBytes == null)
                              Center(
                                child: ClipOval(
                                  child: Image.network(
                                    imageUrl,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            if (updatedImageBytes != null)
                              Center(
                                child: ClipOval(
                                  child: Image.memory(
                                    Uint8List.fromList(updatedImageBytes!),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: fileButton(
                                waterpermit,
                                'Water Permit',
                                chooseFile1,
                              ),
                            ),
                          ],
                        ),
                        Text('$role'),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person_rounded),
                              labelText: 'First Name',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person_rounded),
                              labelText: 'Last Name',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            readOnly: true,
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person_rounded),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: const Icon(Icons.person_rounded),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final updatedFirstName =
                                        firstNameController.text;
                                    final updatedLastName =
                                        lastNameController.text;
                                    final updatedUsername =
                                        usernameController.text;
                                    final updatedPassword =
                                        passwordController.text;

                                    final updatedUserDetails = {
                                      'firstName': updatedFirstName,
                                      'lastName': updatedLastName,
                                      'username': updatedUsername,
                                      'password': updatedPassword,
                                      'image': waterpermit ?? image,
                                      'role': role,
                                    };

                                    userDetailsProvider
                                        .updateUserDetails(updatedUserDetails);

                                    await submitFile();
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
