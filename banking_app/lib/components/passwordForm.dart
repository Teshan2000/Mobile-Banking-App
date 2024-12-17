import 'package:banking_app/components/button.dart';
import 'package:banking_app/providers/apiProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordForm extends StatefulWidget {
  PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendResetLink(String email) async {
    final response = await ApiProvider().sendResetLink(email: email);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to reset password!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Reset Your Password',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          const Center(
            child: Text(
              'Please enter your registered email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: const Color.fromRGBO(89, 139, 225, 1),
            decoration: InputDecoration(
              hintText: "Email Address",
              labelText: "Email Address",
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.email_outlined),
              prefixIconColor: const Color.fromRGBO(89, 139, 225, 1),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: const Color.fromRGBO(89, 139, 225, 1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your registered email';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          Button(
            width: double.infinity,
            title: 'Reset Password',
            disable: false,
            onPressed: () {
              sendResetLink(_emailController.text);
            },
          ),
        ],
      ),
    );
  }
}
