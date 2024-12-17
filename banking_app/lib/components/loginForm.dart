import 'dart:convert';
import 'package:banking_app/components/button.dart';
import 'package:banking_app/components/passwordForm.dart';
import 'package:banking_app/providers/apiProvider.dart';
import 'package:banking_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  String email = "";
  String password = "";

  void loginUser() async {
    final data = {
      'email': _emailController.text,
      'password': _passController.text,
    };

    try {
      final result = await ApiProvider().postRequest(route: '/login', data: data);
      final response = jsonDecode(result.body);
      if (response['status'] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setBool('isLoggedIn', true);
        await preferences.setInt('user_id', response['user']['id']);
        await preferences.setString('name', response['user']['name']);
        await preferences.setString('email', response['user']['email']);
        await preferences.setString('token', response['token']);
        print('Login successful: ${response['message']}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        print('Login failed: ${response['message']}');
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
          const SizedBox(height: 30),
          Center(
            child: TextButton(
              child: Text(
                'Forgot Your Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.all(10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Container(
                                  width: double.infinity,
                                  height: 350,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
                                  child: PasswordForm(),
                                ),
                              ),
                            ],
                          ))),
                );
              },
            ),
          ),
          Button(
            width: double.infinity,
            title: 'Login',
            disable: false,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                loginUser();
              }
            },
          ),
        ],
      ),
    );
  }
}
