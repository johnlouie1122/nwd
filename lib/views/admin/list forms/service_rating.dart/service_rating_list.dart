import 'package:flutter/material.dart';

class ServiceRatingList extends StatefulWidget {
  const ServiceRatingList({super.key});

  @override
  State<ServiceRatingList> createState() => _ServiceRatingListState();
}

class _ServiceRatingListState extends State<ServiceRatingList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Service Rating'),
      ),
      body: AlertDialog(
        title: const Center(
          child: Text(
            'NWD Service Rating List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        scrollable: true,
        content: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 1'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 2'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 3'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 4'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 5'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 6'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 7'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 8'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 9'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 10'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 11'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 12'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 13'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 14'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 15'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 16'),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set width to screen width
              child: ListTile(
                title: const Text('Service Rating sample List 17'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}