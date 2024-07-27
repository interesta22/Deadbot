import 'package:testt/screens/signin1.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/util/consts.dart';
import 'package:testt/widgets/info_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user});
  final User? user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(user2: user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user2;
  _ProfileScreenState({this.user2});
  String? email;
  String? password;
  String? phone;
  String? name;
  bool isDataLoaded = false;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetch();
  }

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
      backgroundColor: Is ? TColors.light : TColors.dark,
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Your Profile',
          style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: isDataLoaded
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Components(
                  Is: Is,
                  email: email ?? 'No email available',
                  password: password ?? 'No password available',
                  name: name ?? 'No name available',
                  phone: phone ?? 'No phone available',
                ),
              )
            : hasError
                ? Text('Error: $errorMessage')
                : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      try {
        
        if (firebaseUser.providerData
            .any((userInfo) => userInfo.providerId == 'google.com')) {
          setState(() {
            name = firebaseUser.displayName;
            email = firebaseUser.email;
            phone = 'No phone available';
            password = 'No password available';
            isDataLoaded = true;
          });
        } else if (firebaseUser.providerData
            .any((userInfo) => userInfo.providerId == 'facebook.com')) {
          setState(() {
            name = firebaseUser.displayName;
            email = firebaseUser.email;
            phone = firebaseUser.phoneNumber;
            password = 'No password available';
            isDataLoaded = true;
          });
        } 
        else {
        
          final userDocument = await FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .get();
          final user = userDocument.data();
          setState(() {
            name = user?['Name'] ?? 'No name available';
            phone = user?['Phone'] ?? 'No phone available';
            email = user?['Email'] ?? 'No email available';
            password = user?['Password'] ?? 'No password available';
            isDataLoaded = true;
          });
        }
      } catch (e) {
        setState(() {
          hasError = true;
          errorMessage = e.toString();
        });
      }
    } else {
      setState(() {
        hasError = true;
        errorMessage = 'No user is currently signed in.';
      });
    }
  }

}

class Components extends StatelessWidget {
  Components({
    super.key,
    required this.Is,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  final bool Is;
  final String email;
  final String password;
  final String phone;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 20),
          child: CircleAvatar(
            backgroundColor: Is
                ? TColors.dark.withOpacity(0.1)
                : TColors.light.withOpacity(0.1),
            radius: 60,
            child: Image(
              width: 110,
              height: 110,
              image: AssetImage('images/Saly-11.png'),
            ),
          ),
        ),
        Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        InfoItem(
          title: 'Phone Number',
          value: phone,
        ),
        InfoItem(
          title: 'Email',
          value: email,
        ),
        InfoItem(
          title: 'Password',
          value: password,
        ),
        SizedBox(
          height: 75,
        ),
        GestureDetector(
          onTap: () async {
            GoogleSignIn googlesignin = GoogleSignIn();
            googlesignin.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn1()),
            );
            PopAct(context, 'Signed out successfully!');
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign out', style: MyFonts.buttonwhite),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Iconsax.profile_remove5,
                    color: Colors.white,
                  )
                ],
              )),
              width: 327,
              height: 52,
              decoration: BoxDecoration(
                  color: Color(0xffE4003A),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  void PopAct(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
