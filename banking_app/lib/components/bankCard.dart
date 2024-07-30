import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  const BankCard(
      {super.key,
      required this.name,
      required this.cardNumber,
      required this.bankName,
      required this.expireDate,
      required this.color,
      required this.cardType});

  final String name;
  final String cardNumber;
  final String bankName;
  final String expireDate;
  final String cardType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: color,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(name,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
              Text(expireDate,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
            ]),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Image.asset(
                'assets/sim.png',
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
              Text(cardNumber,
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(bankName,
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
              Image.asset(
                cardType,
                width: 44,
                height: 38,
                fit: BoxFit.cover,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
