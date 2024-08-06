import 'package:banking_app/components/bankCard.dart';
import 'package:banking_app/components/button.dart';
import 'package:banking_app/screens/addCard.dart';
import 'package:banking_app/screens/transactions.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
          leading: IconButton(
            onPressed: () {Navigator.of(context).pop();},
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Center(
              child: Text(
            'Payments',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Colors.white),
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
                child: Column(children: [
              const Center(
                child: Text(
                  'Choose Your Card',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 170,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(children: [
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.add)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CardDetails()));
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const BankCard(
                        name: 'Peter Parker',
                        cardNumber: '5865 6564 4654 5892',
                        bankName: 'Sampath Bank',
                        expireDate: '03/24',
                        cardType: 'assets/master.png',
                        color: Colors.yellow,
                      ),
                      const BankCard(
                        name: 'Peter Parker',
                        cardNumber: '5865 6564 4654 5892',
                        bankName: 'HNB',
                        expireDate: '04/23',
                        cardType: 'assets/visa.png',
                        color: Colors.orange,
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const ShapeDecoration(
                      color: Color.fromRGBO(62, 102, 236, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Your Card Balance',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color.fromRGBO(62, 102, 236, 1)),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  'Rs. 15, 368.00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 27,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(thickness: 2, color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'Account Number',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Account Holder',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 13),
                                Text(
                                  'Pin Number',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 1),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.deepPurple,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 1),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.deepPurple,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 1),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.deepPurple,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 1),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.deepPurple,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(height: 10),
              Button(
                title: 'Make Payment',
                width: double.infinity,
                disable: false,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => BottomSheet(
                      onClosing: () {
                        TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close),
                            label: const Text('Close'));
                      },
                      builder: (BuildContext context) {
                        return SizedBox(height: 165,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35),
                            child: Column(
                              children: [
                                const Text(
                                  'Are you sure to make this payment?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Button(
                                      title: 'Confirm',
                                      width: 165,
                                      disable: false,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Transactions()));
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    Button(
                                      title: 'Cancel',
                                      width: 165,
                                      disable: false,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Payments()));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );                  
                },
              ),
            ]))));
  }
}
