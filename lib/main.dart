import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user_model.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  var box = await Hive.openBox<UserModel>('users');
  String? loggedInUser = box.get('loggedInUser')?.username;

  runApp(MyApp(
      initialScreen:
          loggedInUser != null ? const HomeScreen() : const LoginScreen()));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Login',
      home: initialScreen,
    );
  }
}
