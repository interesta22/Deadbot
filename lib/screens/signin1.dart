import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:testt/screens/navigation_menu.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/util/consts.dart';
import 'package:testt/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn1 extends StatefulWidget {
  const SignIn1({super.key});

  @override
  State<SignIn1> createState() => _SignIn1State();
}

class _SignIn1State extends State<SignIn1> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }

    bool Is = isLight();
    
    
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: TColors.primary,
        backgroundColor: Colors.grey,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xffE4003A),
                  radius: 120,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: const Image(
                      width: 230,
                      height: 230,
                      image: AssetImage('images/Saly-1.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Let\'s you in',
                  style: Is 
                  ? const TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.black,fontFamily: 'Poppins') 
                  : const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Poppins')
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(() async {
                  await signInWithGoogle(context);
                }, 'Continue with google', 'images/Group.png'),
                Container(
                  margin: const EdgeInsets.only(right: 36, left: 36,bottom: 10),
                  child: Row(
                    children: [
                      const Expanded(
                        child: const Divider(
                          color: Color(0xffE4003A),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          'OR',
                          style: MyFonts.font13grey,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Color(0xffE4003A),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(() {
                  Navigator.pushReplacementNamed(context, 'Login');
                }, 'Sign in with password', 'images/use.png'),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: MyFonts.font13grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'Register');
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: GoogleFonts.fredoka.call().fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffE4003A),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      isLoading = false;
      setState(() {});
      if (googleUser == null) {
        PopAct(context, 'Signed in failed!');
        isLoading = false;
        setState(() {});
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
      PopAct(context, 'Signed in successfuly!');
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: user)),
        (Route<dynamic> route) => false,
      );
      isLoading = false;
      setState(() {});

      if (user != null) {
        final String displayName = user.displayName ?? 'No display name';
        final String email = user.email ?? 'No email';

        print('Display Name: $displayName');
        print('Email: $email');

        
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }
  void PopAct(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
