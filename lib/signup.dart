import 'dart:io';
import 'package:bestbybuddy/view_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(SignupPage());
}

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  static const Color appbarcolour = Color(0xFF36D582);
  static const Color bgcolour = Color(0xFF000000);
  static const Color containercolour = Color(0xFF252525);
  static const Color buttoncolour = Color(0xFFDDF7EB);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    String username = usernameController.text;
    String name = nameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      // Passwords don't match, show an error message
      print("Passwords don't match");
      return;
    }

    // Send the data to your API endpoint
    var url = Uri.parse('http://bhindi1.ddns.net/register');
    //var url = Uri.parse('http://bhindi1.ddns.net/imgrecv');
    var response = await http.post(
      url,
      body: {
        'username': username,
        'name': name,
        'password': password,
      },
    );

    final directory = await getApplicationDocumentsDirectory();
    // Write username to a text file
    final userFile = File('${directory.path}/userFile.txt');
    await userFile.writeAsString(username);
    // String contents = await userFile.readAsString();
    // print(contents);

    print(response.body);

    if (response.statusCode == 200) {
      // Handle successful signup
      print('Signup successful');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewMenu()));
    } else {
      // Handle signup failure
      print('Signup failed');
    }

    // Save response body to a text file
    saveResponseBody(response.body);
    print("Response saved");
  }

  Future<void> saveResponseBody(String body) async {
    try {
      // Parse the JSON response
      Map<String, dynamic> jsonResponse = jsonDecode(body);

      // Extract DEVICE-COOKIE and DEVICE-JWT
      String deviceCookie = jsonResponse['DATA']['COOKIE']['DEVICE-COOKIE'];
      String deviceJwt = jsonResponse['DATA']['JWT']['DEVICE-JWT'];

      // Get the directory for storing files
      final directory = await getApplicationDocumentsDirectory();
      print(directory);

      //File file2 = File(r'/data/user/0/com.example.bestbybuddy/app_flutter/demo.txt');
      // String contents = await file2.readAsString();
      // print(contents);

      // Write response body to a text file
      final file = File('${directory.path}/response_body.txt');
      await file.writeAsString(body);
      // String contents = await file.readAsString();
      // print(contents);

      // Write DEVICE-COOKIE to a text file
      final cookieFile = File('${directory.path}/device_cookie.txt');
      await cookieFile.writeAsString(deviceCookie);

      // Write DEVICE-JWT to a text file
      final jwtFile = File('${directory.path}/device_jwt.txt');
      await jwtFile.writeAsString(deviceJwt);



      // If all writes are successful, print a success message
      print('Files saved successfully');
    } catch (e) {
      // If any error occurs, print the error message
      print('Error saving files: $e');
    }
  }


  // Future<void> sendDeviceJWT(String deviceJwt) async {
  //   var url = Uri.parse('http://example.com/api/set-cookie');
  //   var response = await http.post(
  //     url,
  //     headers: {'BEARER-JWT': deviceJwt},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('DEVICE-JWT sent successfully');
  //   } else {
  //     print('Failed to send DEVICE-JWT');
  //   }
  // }
  //
  // Future<void> sendDeviceCookie(String deviceCookie) async {
  //   var url = Uri.parse('http://example.com/api/set-cookie');
  //
  //   // Create a new HttpClientRequest.
  //   var request = await HttpClient().postUrl(url);
  //
  //   // Set the cookie in the request headers.
  //   request.cookies.add(Cookie('DEVICE-COOKIE', deviceCookie));
  //
  //   // Send the request and get the response.
  //   var response = await request.close();
  //
  //   // Check the response status code.
  //   if (response.statusCode == 200) {
  //     print('DEVICE-COOKIE sent successfully');
  //   } else {
  //     print('Failed to send DEVICE-COOKIE');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Gotham'),
      home: Scaffold(
        backgroundColor: SignupPage.bgcolour,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Best By Buddy",
                      style: TextStyle(
                        color: SignupPage.appbarcolour,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22, color: SignupPage.buttoncolour),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: SignupPage.containercolour,
                        prefixIcon: const Icon(Icons.person_outline, color: SignupPage.appbarcolour,),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: SignupPage.buttoncolour),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: SignupPage.containercolour,
                        filled: true,
                        prefixIcon: const Icon(Icons.person, color: SignupPage.appbarcolour,),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: SignupPage.buttoncolour),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: SignupPage.containercolour,
                        filled: true,
                        prefixIcon: const Icon(Icons.password, color: SignupPage.appbarcolour,),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: SignupPage.buttoncolour),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: SignupPage.containercolour,
                        filled: true,
                        prefixIcon: const Icon(Icons.password, color: SignupPage.appbarcolour,),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(color: SignupPage.buttoncolour),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: signUp,
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: SignupPage.bgcolour),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: SignupPage.buttoncolour,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?", style: TextStyle(color: SignupPage.buttoncolour, fontSize: 16),),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: SignupPage.appbarcolour, fontSize: 20,),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
