import 'dart:convert';
import 'package:banking_app/components/button.dart';
import 'package:banking_app/providers/apiProvider.dart';
import 'package:banking_app/screens/login.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  void registerUser() async {
    final data = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passController.text,
    };

    try {
      final result =
          await ApiProvider().postRequest(route: '/register', data: data);
      final response = jsonDecode(result.body);
      if (response['status'] == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print('Register failed: ${response['message']}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: const Color.fromRGBO(89, 139, 225, 1),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Username',
              labelText: 'Username',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.person_outlined),
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
            onChanged: (val) {
              setState(() {
                fullName = val;
              });
            },
            validator: (val) {
              if (val!.isNotEmpty) {
                return null;
              } else {
                return "Name cannot be empty";
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: const Color.fromRGBO(89, 139, 225, 1),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Email Address',
              labelText: 'Email Address',
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
            validator: (val) {
              return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val!)
                  ? null
                  : "Please enter a valid email";
            },
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: const Color.fromRGBO(89, 139, 225, 1),
            obscureText: obsecurePass,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
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
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: const Color.fromRGBO(89, 139, 225, 1),
                          ))),
            validator: (val) {
              if (val!.length < 6) {
                return "Password must be at least 6 characters";
              } else {
                return null;
              }
            },
            onChanged: (val) {
              setState(() {
                password = val;
              });
            },
          ),
          const SizedBox(height: 20),
          Button(
            width: double.infinity,
            title: 'Register',
            disable: false,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                registerUser();
              }
            },
          ),
        ],
      ),
    );
  }
}
