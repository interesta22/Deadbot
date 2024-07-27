import 'package:testt/screens/navigation_menu.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/util/consts.dart';
import 'package:testt/widgets/custom_button.dart';
import 'package:testt/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email;
  late String password;
  late String phone;
  late String Name;

  late bool _obSecure;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _obSecure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(String uid) {
      return users.doc(uid).set(
          {'Email': email, 'Name': Name, 'Password': password, 'Phone': phone});
    }

    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: TColors.primary,
        backgroundColor: Colors.grey,
      ),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
          child: Form(
            key: formKey,
            child: SafeArea(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffE4003A),
                      radius: 70,
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: const Image(
                          width: 230,
                          height: 230,
                          image: AssetImage('images/Saly-11.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 21),
                    child: CustomTextField(
                      hint: 'Name',
                      onchanged: (data) {
                        Name = data;
                      },
                      icon: Icons.person,
                      controller: _nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: CustomTextField(
                      hint: 'E-mail',
                      onchanged: (data) {
                        email = data;
                      },
                      icon: Icons.mail,
                      controller: _emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(
                      hint: 'Phone Number',
                      onchanged: (data) {
                        phone = data;
                      },
                      icon: Icons.call,
                      controller: _phoneController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obSecure,
                      // ignore: body_might_complete_normally_nullable
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Required';
                        }
                      },
                      onChanged: (data) {
                        password = data;
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_obSecure == true) {
                                  _obSecure = false;
                                } else if (_obSecure == false) {
                                  _obSecure = true;
                                }
                              });
                            },
                            icon: _obSecure
                                ? const Icon(Icons.visibility, color: Colors.grey)
                                : const Icon(Icons.visibility_off,
                                    color: TColors.primary)),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        hintText: 'Password',
                        hintStyle: MyFonts.font13grey,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 20),
                          child: Icon(
                            Icons.lock,
                            color: TColors.primary,
                            size: 21,
                          ),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffE4003A))),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: Colors.grey,
                        backgroundColor: const Color(0xffE4003A),
                        disabledForegroundColor: Colors.grey,
                        disabledBackgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        fixedSize: const Size(327, 56)
                        ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          UserCredential userCredential = await UserRegsisteration();
                          String uid = userCredential.user!.uid;
                          await addUser(uid);

                          PopAct(context, 'Account is created successfully!');
                          isLoading = false;
                          setState(() {});
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            PopAct(context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            PopAct(context, 'The account already exists for that email.');
                          }
                        } catch (e) {
                          PopAct(context, 'An error occurred: $e');
                        }

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sign up', style: MyFonts.buttonwhite),
                        const SizedBox(
                          width: 15,
                        ),
                        const Image(
                          image: AssetImage('images/right-arrow.png'),
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xffE4003A),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or Continue With',
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
                  CustomButton(() async {
                    await signInWithGoogle(context);
                  }, 'Continue with google', 'images/Group.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: MyFonts.font13grey,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log in',
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
      ),
    );
  }

  void PopAct(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<UserCredential> UserRegsisteration() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
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

    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }
  }
}

