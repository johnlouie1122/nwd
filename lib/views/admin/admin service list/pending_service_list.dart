import 'package:flutter/material.dart';

List<String> list = <String>['Transfer of OwnerShip', 'Voluntary Disconnection', 'Water Meter Calibration', 'Change Water Meter', 'Reconnection'];

class PendingServiceList extends StatefulWidget {
  const PendingServiceList({Key? key}) : super(key: key);

  @override
  State<PendingServiceList> createState() => _PendingServiceListState();
}

class _PendingServiceListState extends State<PendingServiceList> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Service Requests'),
      ),
      body: AlertDialog(
        title: const Center(
          child: Text(
            'NWD Pending Service Requests List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        scrollable: true,
        content: Column(
          children: [
            SizedBox(
              width: 500,
              child: DropdownButtonFormField<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                decoration: const InputDecoration(
                  labelText: 'Filter by Service Type',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 1'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 2'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 3'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 4'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 5'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 6'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 7'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 8'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 9'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 10'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 11'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 12'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 13'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 14'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 15'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 16'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Request List Sample 17'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
