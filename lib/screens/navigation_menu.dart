import 'package:testt/screens/Gemini.dart';
import 'package:testt/screens/profile.dart';
import 'package:testt/screens/settings.dart';
import 'package:testt/util/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user});
  final User? user; 


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user2;
  _HomePageState({this.user2});
  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }
    bool isLoading = false;

    bool Is = isLight();
    final controller = Get.put(NavigationController(screens: [const GeminiScreen(), ProfileScreen(user: user2,), const SettingScreen()]),permanent: true);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Is ? TColors.dark.withOpacity(0.1) : TColors.light.withOpacity(0.1),
              backgroundColor: Is ? TColors.light : TColors.dark,
              labelTextStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: Is ? TColors.dark : TColors.light,
                ),
              ),
              iconTheme: WidgetStatePropertyAll(
                IconThemeData(
                  color: Is ? TColors.dark : TColors.light,
                ),
              ),
            ),
            child: NavigationBar(
              height: 60,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                const NavigationDestination(icon: Icon(Iconsax.home,), label: 'Home',),
                const NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
                const NavigationDestination(
                    icon: Icon(Iconsax.setting), label: 'Settings'),
              ],
            ),
          ),
        ),
        body: Obx(() => IndexedStack(children: controller.screens,index: controller.selectedIndex.value,)),
      ),
    );
  }
}
class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  NavigationController({this.screens});

  final screens ;
}
