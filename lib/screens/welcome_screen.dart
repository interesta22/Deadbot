import 'package:testt/util/consts.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else {
        return false;
      }
    }

    bool Is = isLight();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text('Welcome to', style: Is ? MyFonts.welcomefont1 : MyFonts.welcomefont2),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Image(
                  image: Is
                      ? const AssetImage('images/welcome light .png')
                      : const AssetImage('images/welcome dark.png')),
            ),
            const SizedBox(
              height: 70,
            ),
            Text('The right answers in a flash', style: Is ? MyFonts.font22black : MyFonts.font22white),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 7),
              child: Text(
                'Much faster than compare solutions,replies like coversations',
                style: MyFonts.font13grey,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            GestureDetector(
              onTap: () {
                final box = GetStorage();
                box.write('firstLaunch', false); // Set the flag to false
                Navigator.pushReplacementNamed(
                    context, 'Sign in 1'); // Replace with your home route
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: 327,
                  height: 56,
                  decoration: BoxDecoration(
                      color: const Color(0xffE4003A),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Get started', style: MyFonts.buttonwhite),
                      const SizedBox(
                        width: 15,
                      ),
                      const Image(
                        image: AssetImage('images/right-arrow.png'),
                        height: 14,
                        width: 14,
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
