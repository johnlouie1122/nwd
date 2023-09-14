import 'package:flutter/material.dart';
import 'package:nwd/views/services%20forms/transfer/main/deceasedMain.dart';
import 'package:nwd/views/services%20forms/transfer/main/normal_transfer.dart';
import 'package:nwd/views/services%20forms/transfer/main/propertyMain.dart';

class TransferDialog extends StatefulWidget {
  const TransferDialog({super.key});

  @override
  State<TransferDialog> createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Transfer of Ownership Requirements',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.blue)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'NWD Waiver Transfer of Ownership (signed by old and new member)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Deed of sale / Lot title / other documents (proof of land ownership) must be under the new owner's name",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'If the owner of the account is already deceased: Waiver / consent from the other member of the immediate family allowing the new member to change the account, Death Certificate',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'If the new or old member is not present (e.g working abroad): They must provide an Authorization letter, 1 Copy of valid ID of the representative',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: const Text(
                                                  'Reason for Transfer',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Center(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushAndRemoveUntil(
                                                                      MaterialPageRoute(builder:
                                                                          (BuildContext
                                                                              context) {
                                                                return const NormalTransferMain();
                                                              }),
                                                                      (route) =>
                                                                          false);
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'assets/images/agreement.png'),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(builder:
                                                                        (BuildContext
                                                                            context) {
                                                                  return const NewPropertyMain();
                                                                }),
                                                                    (route) =>
                                                                        false);
                                                              },
                                                              child:
                                                                  const SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      'assets/images/house.png'),
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                              'Normal Transfer'),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                              'New Property Owner'),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                               Navigator.of(context).pushAndRemoveUntil(
                                                                    MaterialPageRoute(builder:
                                                                        (BuildContext
                                                                            context) {
                                                                  return const DeceasedMain();
                                                                }),
                                                                    (route) =>
                                                                        false);
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'assets/images/tombstone.png'),
                                                              ),
                                                            ),
                                                          ),
                                                          const Text(
                                                              'Deceased Owner'),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/person.png'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  scrollable: true,
                                                  title: const Text(
                                                    'Reason for Transfer',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Center(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {},
                                                              child:
                                                                  const SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      'assets/images/agreement.png'),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    const SizedBox(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/images/house.png'),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                        const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                                'Normal Transfer'),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(
                                                                'New Property Owner'),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {},
                                                              child:
                                                                  const SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      'assets/images/tombstone.png'),
                                                                ),
                                                              ),
                                                            ),
                                                            const Text(
                                                                'Deceased Owner'),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/representative.png'),
                                          ),
                                        )),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      });
                },
                child: const Text('S T A R T'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
