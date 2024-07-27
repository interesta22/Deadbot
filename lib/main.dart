import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testt/firebase_options.dart';
import 'package:testt/screens/Gemini.dart';
import 'package:testt/screens/about.dart';
import 'package:testt/screens/navigation_menu.dart';
import 'package:testt/screens/login_screen.dart';
import 'package:testt/screens/notefication.dart';
import 'package:testt/screens/welcome_screen.dart';
import 'package:testt/screens/profile.dart';
import 'package:testt/screens/register.dart';
import 'package:testt/screens/signin1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testt/util/theme.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final box = GetStorage();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool firstLaunch = box.read('firstLaunch') ?? true;
    bool isLight() {
      if (Provider.of<ThemeProvider>(context).themeData.brightness == Brightness.light) {
        return true;
      } else
        return false;
    }

    bool Is = isLight();
    if (Is) {
      FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData, 
      debugShowCheckedModeBanner: false,
      home: firstLaunch ? OnBoardingScreen() : AuthWrapper(),
      routes: {
        'Login': (context) => LoginScreen(),
        'Register': (context) => RegisterScreen(),
        'Sign in 1': (context) => SignIn1(),
        'OnBoarding': (context) => OnBoardingScreen(),
        'gemini screen': (context) => GeminiScreen(),
        'Home': (context) => HomePage(),
        'Profile': (context) => ProfileScreen(),
        'Note': (context) => NoteficationScreen(),
        'About': (context) => AboutScreen()
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginScreen();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
