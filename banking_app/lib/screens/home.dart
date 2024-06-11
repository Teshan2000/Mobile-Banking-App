import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Welcome', style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.purple,
        actions: const [
          EndDrawerButton(color: Colors.white),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: []
        )
      )
    );
  }
}
