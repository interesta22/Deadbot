import 'package:provider/provider.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/util/theme.dart';
import 'package:testt/widgets/setting_item.dart';
import 'package:testt/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }

    bool Is = isLight();

    return Scaffold(
      backgroundColor: Is ? TColors.light : TColors.dark,
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Account",
                icon: Iconsax.profile_tick,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                onTap: () {
                  Navigator.pushNamed(context, 'Profile');
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Notifications",
                icon: Iconsax.notification,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                onTap: () {
                  Navigator.pushNamed(context, 'Note');
                },
              ),
              const SizedBox(height: 20),
              SettingSwitch(
                  value: !Is,
                  title: "Dark Mode",
                  icon: Iconsax.moon,
                  bgColor: Colors.purple.shade100,
                  iconColor: Colors.purple,
                  onTap: (value) {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    return value;
                  }),
              const SizedBox(height: 20),
              SettingItem(
                title: "About",
                icon: Iconsax.information4,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pushNamed(context, 'About');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
