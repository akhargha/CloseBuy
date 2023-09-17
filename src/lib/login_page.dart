import 'package:flutter/material.dart';
import 'bottom_nav.dart';

void main() { runApp(LoginApp()); }

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.black,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Stack(
          children: [
            Container(
              color: Color(0xFFc4ff61),  // Your desired hex color
            ),
            Center(
              child: Image.asset('lib/background.png', fit: BoxFit.cover),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final enteredEmail = _emailController.text;
                final enteredPassword = _passwordController.text;

                if (enteredEmail == 'chickens.for.change@trincoll.edu' && enteredPassword == '12345') {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => BottomNavBarApp(),
                  ));
                } else {
                  // Display an error message for failed login
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid credentials')),
                  );
                }

              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
