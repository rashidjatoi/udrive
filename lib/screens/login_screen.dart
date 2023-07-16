import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udrive/screens/main_page.dart';
import 'package:udrive/utils/utils.dart';
import 'package:udrive/widgets/texi_outline_button.dart';
import '/constants/colors.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    void loginUser() async {
      await auth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .catchError(
        (error) {
          PlatformException thisEx = error;
          Utils.showSnackBar(message: thisEx.toString(), context: context);
        },
      ).then(
        (value) => Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.id, (route) => false),
      );
    }

    return Scaffold(
      backgroundColor: BrandColors.whiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sizebox
              SizedBox(height: mq.height * 0.2),

              //App Image
              const Image(
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,
                image: AssetImage("assets/images/logo.png"),
              ),

              // Sizebox
              const SizedBox(height: 30),

              // Text
              const Text(
                "Sign In as a U-rider",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: ' Roboto Medium'),
              ),

              // Sizebox
              const SizedBox(height: 30),

              //Email TextField
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(fontSize: 14.0),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
              ),

              // Sizebox
              const SizedBox(height: 10),

              //Password TextField
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 14.0),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
              ),

              // Sizebox
              const SizedBox(height: 40),

              // Button
              TaxiOutlineButton(
                title: "LOGIN",
                color: BrandColors.colorGreen,
                textColor: BrandColors.whiteColor,
                onPressed: () {
                  if (passwordController.text.length <= 6) {
                    Utils.showSnackBar(
                      message: "Password must be greater then 6",
                      context: context,
                    );
                    return;
                  }
                  if (!emailController.text.contains('@')) {
                    Utils.showSnackBar(
                      message: "Please enter a valid Email",
                      context: context,
                    );
                    return;
                  }

                  loginUser();
                },
              ),

              // Sizebox
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont't have an account"),
                  const SizedBox(width: 8),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RegisterScreen.id, (route) => false);
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
