import 'package:flutter/material.dart';

class AppliedService extends StatefulWidget {
  const AppliedService({super.key});

  @override
  State<AppliedService> createState() => _AppliedServiceState();
}

class _AppliedServiceState extends State<AppliedService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Services List'),
      ),
      body: AlertDialog(
        scrollable: true,
        content: Center(
          child: Column(
            children: [
              ListTile(
                title: const Text('Voluntary Disconnection Request'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            const Text('Was the Service Request Resolved?'),
                        actions: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('YES'),
                          ),
                          TextButton(onPressed: () {}, child: const Text('NO'))
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
