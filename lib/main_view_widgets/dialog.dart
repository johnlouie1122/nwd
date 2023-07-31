import 'package:flutter/material.dart';
import 'package:nwd/views/New%20Water%20Connection/main%20applicant/tc_mainapplicant.dart';
import 'package:nwd/views/New%20Water%20Connection/representative/tc_representative.dart';

class ConnectionDialog extends StatefulWidget {
  const ConnectionDialog({Key? key}) : super(key: key);

  @override
  State<ConnectionDialog> createState() => _ConnectionDialogState();
}

class _ConnectionDialogState extends State<ConnectionDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          scrollable: true,
          title: const Text(
            'Are you a?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return const TermsAndConditionsMainApplicant();
                          }));},
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return const TermsAndConditionsRepresentative();
                          }));
                        },
                        child: const SizedBox(
                          height: 50,
                          width: 50,
                          child: Image(
                            image:
                                AssetImage('assets/images/representative.png'),
                          ),
                        )),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Main Applicant'),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Representative'),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}