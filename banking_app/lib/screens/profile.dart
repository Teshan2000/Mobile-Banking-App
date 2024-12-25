import 'dart:convert';
import 'dart:io';
import 'package:banking_app/components/button.dart';
import 'package:banking_app/providers/apiProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const Profile({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SharedPreferences? preferences;
  String? photoUrl;
  File? _image;
  List<ProfileDetails> profile = [];

  @override
  void initState() {
    super.initState();
    // _fetchProfile();
  }

  Future<void> saveUserData(String name, String email, String password) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('name', name);
    preferences.setString('email', email);
    preferences.setString('password', password);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      // Only send fields that have been updated
      String? updatedName =
          nameController.text != widget.name ? nameController.text : null;
      String? updatedEmail =
          emailController.text != widget.email ? emailController.text : null;
      String? updatedTel =
          telController.text.isNotEmpty ? telController.text : null;
      String? updatedPassword = passwordController.text != widget.password
          ? passwordController.text
          : null;

      await ApiProvider().uploadProfile(
        name: updatedName,
        telNumber: updatedTel,
        emailAddress: updatedEmail,
        password: updatedPassword,
        profilePic: _image,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      // Save updated data locally
      // await saveUserData(
      //   nameController.text,
      //   emailController.text,
      //   passwordController.text,
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(89, 139, 225, 1),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Center(
              child: Text(
            'Profile',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu,
                  color: Color.fromRGBO(89, 139, 225, 1)),
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
                child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const ShapeDecoration(
                      color: Color.fromRGBO(62, 102, 236, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Edit Your Profile',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 60),
                                Text(
                                  'Profile Picture',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(90),
                                      ),
                                    ),
                                    child: const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.person,
                                          size: 35,
                                        )),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: _buildTextField(
                                    'Name', 
                                    nameController
                                  )
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: _buildTextField(
                                    'Name', 
                                    telController
                                  )
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: _buildTextField(
                                    'Name', 
                                    emailController
                                  )
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 25,
                                  child: _buildTextField(
                                    'Name', 
                                    passwordController
                                  )
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: Column(
                          children: [
                            ExpansionTile(
                              key: UniqueKey(),
                              // leading: const Icon(Icons.payment, color: Colors.white,),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: const Text(
                                "Bank Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                "2 Accounts",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              children: [
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sampath Bank',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              '5865 6554 4654 5892',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/master.png",
                                                  width: 48,
                                                  height: 48,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'HNB',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              '5865 6554 4654 5892',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/visa.png",
                                                  width: 48,
                                                  height: 48,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(height: 10),
              Button(
                title: 'Save Details',
                width: double.infinity,
                disable: false,
                onPressed: () {},
              ),
            ]))));
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 14),
        // keyboardType: TextInputType.name,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.deepPurple,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
        ),      
    );
  }
}

class ProfileDetails {
  final String name;
  final String telNumber;
  final String emailAddress;
  final String profilePic;

  ProfileDetails({
    required this.name,
    required this.telNumber,
    required this.emailAddress,
    required this.profilePic,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      name: json['name'] ?? '',
      telNumber: json['telNumber'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      profilePic: json['profilePic'] ?? '',
    );
  }
}
