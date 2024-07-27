import 'package:testt/util/colors.dart';
import 'package:flutter/material.dart';

class NoteficationScreen extends StatelessWidget {
  const NoteficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Notifications',
              style: TextStyle(fontSize: 25, color: Colors.grey,fontWeight: FontWeight.w500),
            ),
            Text('Yet!',
              style: TextStyle(fontSize: 25, color: Colors.grey,fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}