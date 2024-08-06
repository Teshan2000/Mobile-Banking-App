import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
          title: const Center(
              child: Text(
            'Transactions',
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
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const ShapeDecoration(
                      color: Color.fromRGBO(62, 102, 236, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 625,
                      child: ListView(
                        children: List.generate(3, (index) {
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Peter Parker',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text('Rs. 750.00',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                      ]),
                                  SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('5865 6564 4654 5892',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ]),
                                  SizedBox(height: 8),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Sampath Bank',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text('Aug 23',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]))
            ]))));
  }
}
