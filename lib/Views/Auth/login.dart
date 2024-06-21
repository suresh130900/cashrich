import 'package:cash_rich/Views/Auth/signup.dart';
import 'package:cash_rich/Views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  //Firebase Auth with google
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      Get.snackbar("inputs", "Please Fill all Fields",
          backgroundColor: Colors.white);
    } else if (password != cPassword) {
      Get.snackbar("not matching", "Passwords do not match",
          backgroundColor: Colors.white);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Get.snackbar("Sucess", "User Registered Sucessfully",
            backgroundColor: Colors.white);
        print(userCredential.user);
        if (userCredential.user != null) {
          Get.off(const Home());
          //Sip calculator
        }
      } on FirebaseAuthException catch (ex) {
        Get.snackbar("Exception", ex.code.toString(),
            backgroundColor: Colors.white);
      }
    }
  }

  //Signup with Google
  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth
          .signInWithProvider(googleAuthProvider)
          .then((UserCredential userCredential) {
        Get.offAll(const Home());
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  const Text(
                    "Create an account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome! Please enter your details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: 'Enter Your email',
                        labelStyle: TextStyle(fontSize: 16),
                        prefixIcon: Icon(CupertinoIcons.mail),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: 'Enter Your password',
                        labelStyle: TextStyle(fontSize: 16),
                        prefixIcon: Icon(CupertinoIcons.lock),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: cPasswordController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        labelText: 'Please Confirm your password',
                        labelStyle: TextStyle(fontSize: 16),
                        prefixIcon: Icon(CupertinoIcons.lock),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(16.0)),
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        elevation: WidgetStateProperty.all<double>(5),
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            return states.contains(WidgetState.pressed)
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)
                                : Colors
                                    .transparent; // Set to null to allow the gradient to take effect
                          },
                        ),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        overlayColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            return states.contains(WidgetState.pressed)
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)
                                : Colors.transparent;
                          },
                        ),
                      ),
                      onPressed: () {
                        // Handle button press
                        createAccount();
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.green,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Get.to(() => const SignUp());
                    },
                    child: const Text("Already have an Account"),
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _handleGoogleSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.white, // Background color
                      // onPrimary: Colors.black, // Text color
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/google_logo.png', // Add your Google logo image asset
                          height: MediaQuery.of(context).size.height / 20,
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          'Sign In with Google',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
