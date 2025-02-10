import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _registerUser() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos!")),
      );
      return;
    }

    var box = await Hive.openBox<UserModel>('users');

    if (box.containsKey(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário já existe!")),
      );
      return;
    }

    await box.put(username, UserModel(username: username, password: password));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registro bem-sucedido!")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          "Registrar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/cat_login.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Nome de Usuário",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Senha",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              onPressed: _registerUser,
              child: const Text(
                "Registrar",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
