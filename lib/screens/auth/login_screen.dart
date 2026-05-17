import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("PA Login"),
        backgroundColor: const Color(0xFF6FE7DD),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 50),

            TextField(
              controller: phoneController,

              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                bool success = await authProvider.userLogin(
                  phoneController.text,
                );

                if (success) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Login Failed")));
                }
              },

              child: authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
