import 'package:flutter/material.dart';

class TransferChoices extends StatefulWidget {
  const TransferChoices({super.key});

  @override
  State<TransferChoices> createState() => _TransferChoicesState();
}

class _TransferChoicesState extends State<TransferChoices> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Reason for Transfer',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/images/agreement.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Image(
                        image: AssetImage('assets/images/house.png'),
                      ),
                    )),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Normal Transfer'),
                SizedBox(
                  width: 15,
                ),
                Text('New Property Owner'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/images/tombstone.png'),
                    ),
                  ),
                ),
                const Text('Deceased Owner'),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
