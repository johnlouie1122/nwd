import 'package:flutter/material.dart';
import 'package:nwd/views/admin/adminpage.dart';

class DetailsDialog {
  static void detailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Column(
              children: [
                Text('User Application Details'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ConfirmationDialog.confirmationDialog(context, 'Are you sure you want to decline?');
              },
              child: const Text('Decline'),
            ),
            TextButton(
              onPressed: () {
                ConfirmationDialog.confirmationDialog(context, 'Are you sure you want to Approve?');
              },
              child: const Text('Approve'),
            ),
          ],
        );
      },
    );
  }
}

class ConfirmationDialog {
  static void confirmationDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                 Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                 Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const AdminHomePage();
                        },
                      ),
                    );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

// Widget confimationDialog(BuildContext context, String message) => AlertDialog(
//         title: const Text('Confirmation'),
//         content: SizedBox(
//             width: MediaQuery.of(context).size.width / 4, child: Text(message)),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () {},
//             child: const Text('Yes'),
//           ),
//         ]);
