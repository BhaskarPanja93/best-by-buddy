import 'package:bestbybuddy/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bestbybuddy/view_menu.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  static const String _title = 'BestBy Buddy';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Color appbarcolour = Color(0xFF36D582);
  Color bgcolour = Color(0xFF000000);
  Color containercolour = Color(0xFF252525);
  Color buttoncolour = Colors.grey;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _submitForm(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://your-api-endpoint.com/login'), // Replace with your API endpoint
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle response here
      print('Login successful!');
    } else {
      // Request failed, handle error here
      print('Failed to login: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gotham'),
      home: Scaffold(
        backgroundColor: bgcolour,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'BestBy Buddy',
                  style: TextStyle(
                    color: appbarcolour,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20, color: Color(0xFFDDF7EB)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                child: ElevatedButton(
                  child: Text('Login', style: TextStyle(color: containercolour, fontSize: 18)),
                  onPressed: () {
                    String username = nameController.text;
                    String password = passwordController.text;
                    _submitForm(username, password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ViewMenu()),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Do not have account?',
                    style: TextStyle(color: buttoncolour),
                  ),
                  TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: appbarcolour),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
