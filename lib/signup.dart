import 'package:bestbybuddy/view_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    //print(password);

    if (password != confirmPassword) {
      // Passwords don't match, show an error message
      print("Passwords don't match");
      return;
    }
    else{
      print("Passwords match");
    }

    // Send the data to your API endpoint
    var url = Uri.parse('http://bbb.bhindi1.ddns.net/register');
    var response = await http.post(
      url,
      body: {
        'username': username,
        'name': name,
        'password': password,
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      // Handle successful signup
      print('Signup successful');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ViewMenu()));
    } else {
      // Handle signup failure
      print('Signup failed');
    }
  }

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
                      style: TextStyle(fontSize: 15, color: SignupPage.containercolour),
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
                        fillColor: SignupPage.containercolour,
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                      ),
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
                        prefixIcon: const Icon(Icons.email),
                      ),
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
                        prefixIcon: const Icon(Icons.password),
                      ),
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
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const ViewMenu()),
                      // );
                    },
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
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: SignupPage.appbarcolour),
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
