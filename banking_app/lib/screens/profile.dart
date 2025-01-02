import 'dart:convert';
import 'dart:io';
import 'package:banking_app/components/button.dart';
import 'package:banking_app/providers/apiProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
  // List<ProfileDetails> profile = [];
  // late final Map<dynamic, dynamic> profile;
  // Map<String, dynamic> profile = {};

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  // Future<void> saveUserData(String name, String email, String password) async {
  //   final preferences = await SharedPreferences.getInstance();
  //   preferences.setString('name', name);
  //   preferences.setString('email', email);
  //   preferences.setString('password', password);
  // }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _getSharedPreferenceData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}


  Future<void> fetchProfileData() async {
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/profile/fetch'),
      headers: {
        // 'Authorization': 'Bearer $token', // Remove if token isn't required
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final profileData = responseData['data'][0]; // Adjust index as needed

      // Update controllers with profile data or SharedPreferences fallback
      setState(() {
        photoUrl = profileData['profilePic'] != null
            ? 'http://10.0.2.2:8000/api/storage/${profileData['profilePic']}'
            : null;

        nameController.text = profileData['name'] ?? _getSharedPreferenceData('name') ?? '';
        telController.text = profileData['telNumber'] ?? _getSharedPreferenceData('telNumber') ?? '';
        emailController.text = profileData['emailAddress'] ?? _getSharedPreferenceData('emailAddress') ?? '';
        passwordController.text = profileData['password'] ?? _getSharedPreferenceData('password') ?? '';
      });
    } else {
      print('Failed to fetch profile data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching profile data: $e');
  }
}


  // Future<void> _fetchProfile() async {
  //   final data = {
  //     'name': nameController.text,
  //     'telNumber': telController.text,
  //     // 'password': _passController.text,
  //   };

  //   try {
  //     final result =
  //         await ApiProvider().getRequest(route: '/profile/fetch', data: data);
      
  //     if (result.statusCode == 200) {
        
  //       // Map<String, dynamic> profile = response;
  //       // print('successful: ${profile['data']}');
  //       final response = jsonDecode(result.body)['data'];
  //       print('response: $response');
  //       // return response;
  //       setState(() {
  //         nameController.text = widget.name;
  //           // telController.text = profile['telNumber'] ?? 'H';
  //           emailController.text = widget.email;
  //           passwordController.text = widget.password; // Do not fetch passwords
  //           // photoUrl = profileData['profilePic'] ?? preferences?.getString('photo');
  //         // final orderId = jsonResponse['id'];
  //       });
  //     }
  //     // final response = await ApiProvider().fetchProfile();
  //     // print(response.body);

  //     // final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //     // if (jsonResponse['success'] == true) {
  //     //   setState(() {
  //     //     // profile = jsonResponse['data'] as Map;
  //     //     profile = jsonResponse;
  //     //     print(profile);
  //     //     print('${profile['data']['telNumber']}');
  //     //     // final userProfile = profile;
  //     //     setState(() {
  //     //       nameController.text = widget.name;
  //     //       // telController.text = profile['telNumber'] ?? 'H';
  //     //       emailController.text = widget.email;
  //     //       passwordController.text = widget.password; // Do not fetch passwords
  //     //       // photoUrl = profileData['profilePic'] ?? preferences?.getString('photo');
  //     //     });
  //     //   });
  //     // } else {
  //     //   print("Invalid response format");
  //     // }

  //     // setState(() {
  //     //   nameController.text = profileData['name'] ?? widget.name;
  //     //   telController.text = profileData['telNumber'] ??
  //     //       preferences?.getString('telNumber') ??
  //     //       '';
  //     //   emailController.text = profileData['emailAddress'] ?? widget.email;
  //     //   passwordController.text = widget.password; // Do not fetch passwords
  //     //   photoUrl = profileData['profilePic'] ?? preferences?.getString('photo');
  //     // });
  //   } catch (e) {
  //     print("Error fetching profile: $e");

  //     // Fallback to shared preferences
  //     // setState(() {
  //     //   nameController.text = preferences?.getString('name') ?? widget.name;
  //     //   telController.text = preferences?.getString('telNumber') ?? '';
  //     //   emailController.text = preferences?.getString('email') ?? widget.email;
  //     //   passwordController.text = widget.password;
  //     //   photoUrl = preferences?.getString('photo');
  //     // });
  //   }
  // }

  Future<String> _getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }

  Future<void> uploadProfile() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/profile/store');
  final token = await _getToken(); // Ensure you retrieve the correct token

  // Create a multipart request
  final request = http.MultipartRequest('POST', url);

  // Add headers
  request.headers['Authorization'] = 'Bearer $token';

  // Add form fields
  request.fields['name'] = nameController.text;
  request.fields['telNumber'] = telController.text;
  request.fields['emailAddress'] = emailController.text;
  request.fields['password'] = passwordController.text;

  // Add profile picture (if available)
  if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'profilePic',
      _image!.path, // Replace `_image` with your selected file
    ));
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: ${response.body}')),
      );
    }
  } catch (e) {
    print('Error during upload: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred while updating profile.')),
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
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      image: photoUrl != null
          ? DecorationImage(
              image: NetworkImage(photoUrl!),
              fit: BoxFit.cover,
            )
          : null,
    ),
    child: photoUrl == null
        ? const Icon(
            Icons.person,
            size: 35,
          )
        : null, // Display icon only when there's no profile picture
  ),
),

                                const SizedBox(height: 10),
                                SizedBox(
                                    width: 160,
                                    height: 25,
                                    child: _buildTextField(
                                        keyboardType: TextInputType.name,
                                        nameController)),
                                const SizedBox(height: 10),
                                SizedBox(
                                    width: 160,
                                    height: 25,
                                    child: _buildTextField(
                                        keyboardType: TextInputType.number,
                                        telController)),
                                const SizedBox(height: 10),
                                SizedBox(
                                    width: 160,
                                    height: 25,
                                    child: _buildTextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        emailController)),
                                const SizedBox(height: 10),
                                SizedBox(
                                    width: 160,
                                    height: 25,
                                    child: _buildTextField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        passwordController,
                                        isPassword: true)),
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
                onPressed: uploadProfile,
              ),
            ]))));
  }

  Widget _buildTextField(TextEditingController controller,
      {bool isPassword = false, required TextInputType keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
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
