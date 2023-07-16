import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udrive/provider/app_data_provider.dart';
import 'package:udrive/screens/login_screen.dart';
import 'package:udrive/screens/main_page.dart';
import 'package:udrive/screens/register_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppDataProvider()),
        ],
        child: MaterialApp(
          title: 'Urdive',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Brand-Regular',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                elevation: 0.8,
              )),
          initialRoute: MainScreen.id,
          routes: {
            RegisterScreen.id: (context) => const RegisterScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            MainScreen.id: (context) => const MainScreen(),
          },
        ));
  }
}
