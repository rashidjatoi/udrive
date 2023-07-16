import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udrive/screens/main_page.dart';
// import 'package:udrive/services/check_internet_service.dart';
import 'package:udrive/utils/utils.dart';
import 'package:udrive/widgets/texi_outline_button.dart';
import '/constants/colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String id = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void registerUser() async {
    final User? user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((error) {
      // Catch Error and Display Message
      PlatformException thisEx = error;
      Utils.showSnackBar(message: thisEx.toString(), context: context);
    }))
        .user;

    if (user != null) {
      debugPrint('registration successfully');
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.ref().child("user/${user.uid}");

      Map userMap = {
        "fullName": fullNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
      };

      newUserRef.set(userMap);

      // Take User to main Page
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

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
              SizedBox(height: mq.height * 0.09),

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
                "Create a U-Riders Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'DMSans Bold'),
              ),

              // Sizebox
              const SizedBox(height: 30),

              //Name TextField
              TextField(
                controller: fullNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(fontSize: 14.0),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
              ),

              // Sizebox
              const SizedBox(height: 10),

              //Phone TextField
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Phone number",
                    labelStyle: TextStyle(fontSize: 14.0),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
              ),

              // Sizebox
              const SizedBox(height: 10),

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
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 14.0),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: const TextStyle(fontSize: 14),
                validator: (value) {},
              ),

              // Sizebox
              const SizedBox(height: 40),

              // Button
              TaxiOutlineButton(
                title: "REGISTER",
                color: BrandColors.colorGreen,
                textColor: BrandColors.whiteColor,
                onPressed: () async {
                  // Check Network Connectivity
                  // final message = await CheckInternetService.checkInternet();
                  // Utils.showSnackBar(
                  //     message: message.toString(), context: context);
                  if (fullNameController.text.length < 3) {
                    Utils.showSnackBar(
                      message: "Please enter a valid full name",
                      context: context,
                    );
                    return;
                  }
                  if (phoneController.text.length < 10) {
                    Utils.showSnackBar(
                      message: "Please enter a valid phone number",
                      context: context,
                    );
                    return;
                  }
                  if (!emailController.text.contains('@')) {
                    Utils.showSnackBar(
                      message: "Please enter a valid email",
                      context: context,
                    );
                    return;
                  }
                  if (passwordController.text.length <= 6) {
                    Utils.showSnackBar(
                      message: "Password must be greater then 8",
                      context: context,
                    );
                    return;
                  }

                  registerUser();
                },
              ),

              // Sizebox
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account"),
                  const SizedBox(width: 8),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      },
                      child: const Text(
                        "Sign in",
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
