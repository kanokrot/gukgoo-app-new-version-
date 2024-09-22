import 'package:flutter/material.dart';
import 'package:gukgoo/auth/forget_password.dart';
import 'package:gukgoo/auth/registration_page.dart';
import 'package:gukgoo/screens/home_screen.dart'; 

class LoginPage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkMode;

  const LoginPage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String logoAsset = widget.isDarkMode
        ? 'assets/images/logo2.png' // Dark mode logo
        : 'assets/images/logo.png'; // Light mode logo

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 0.5),
              child: Image.asset(
                logoAsset,
                height: 175,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_4_sharp),
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Forgot Password Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordPage(
                              isDarkMode: widget.isDarkMode,
                              onThemeChanged: widget.onThemeChanged,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outlined),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isDarkMode
                          ? Colors.grey[800]
                          : const Color.fromARGB(255, 45, 46, 37),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // Check if username and password are not empty
                      if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                        // Navigate to the HomeScreen with the username
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(username: _usernameController.text),
                          ),
                        );
                      } else {
                        // Show an error message if login fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter username and password')),
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New to Gukgoo?", 
                        style: TextStyle(color: Color.fromARGB(255, 255, 5, 5)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(
                                isDarkMode: widget.isDarkMode,
                                onThemeChanged: widget.onThemeChanged,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Create a new account',
                          style: TextStyle(
                            color: Colors.amber,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
