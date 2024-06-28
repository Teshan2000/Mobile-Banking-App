import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? preferences;
  bool isLoading = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _initializePreferences() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    if (!_isDisposed) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              elevation: 2,
              color: const Color.fromRGBO(62, 102, 236, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Center(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Center(
                                  child: Icon(
                                Icons.person,
                                size: 50,
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(preferences?.getString('name') ?? 'Your Name',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            preferences?.getString('email') ?? 'Your Email',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Your Account Balance',
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
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Our Services',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: const ShapeDecoration(
                  color: Color.fromRGBO(62, 102, 236, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                crossAxisSpacing: 0,
                mainAxisSpacing: 15,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Card(
                                    elevation: 5,
                                    // width: 70,
                                    // height: 70,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    // decoration: ShapeDecoration(
                                    //   color: const Color.fromARGB(
                                    //       255, 255, 255, 255),
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(20),
                                    //   ),
                                    // ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 14),
                                      child: Center(
                                          child: Icon(
                                        Icons.calculate_outlined,
                                        size: 50,
                                      )),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 70,          
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                    ),
                  ),
              ),  
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.currency_exchange_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    ),
                  ),
              ),  
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.home_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                    ),
                  ),
              ),  
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.insert_chart_outlined_rounded,
                      size: 35,
                      color: Colors.black,
                    ),
                    ),
                  ),
              ),  
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 35,
                      color: Colors.black,
                    ),
                    ),
                  ),
              ),            
            ],
          ),
        ),
      ),
    );
  }
}
