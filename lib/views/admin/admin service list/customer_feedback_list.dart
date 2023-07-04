import 'package:flutter/material.dart';

class CustomerFeedbackList extends StatefulWidget {
  const CustomerFeedbackList({super.key});

  @override
  State<CustomerFeedbackList> createState() => _CustomerFeedbackListState();
}

class _CustomerFeedbackListState extends State<CustomerFeedbackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Feedback'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: AlertDialog(
          title: const Center(
            child: Text(
              'NWD Customer Feedback List',
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
                  title: const Text('Customer Feedback Sample List 1'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 2'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 3'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 4'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 5'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 6'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 7'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 8'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 9'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 10'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 11'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 12'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 13'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 14'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 15'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 16'),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set width to screen width
                child: ListTile(
                  title: const Text('Customer Feedback Sample List 17'),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
