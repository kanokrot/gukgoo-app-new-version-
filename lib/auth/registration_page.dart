import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gukgoo/screens/home_screen.dart';

class RegistrationPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  const RegistrationPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isEmailValid = false;
  bool _isPasswordVisible = false;
  bool _isPasswordValid = false;

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = EmailValidator.validate(email);
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.length >= 8 && password.length <= 15;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 35.0),
              const Text(
                "Welcome to GukGoo!\nLet's the fun begin!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),

              // Email TextField with Conditional Tick Icon
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Enter your Email*',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _validateEmail,
                    ),
                  ),
                  if (_isEmailValid)
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email is valid!')),
                        );
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Password TextField - shown only if email is valid
              if (_isEmailValid)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outlined),
                          labelText: 'Enter your Password*',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          _validatePassword(value);
                        },
                      ),
                    ),
                    if (_isPasswordValid)
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password is valid!')),
                          );
                        },
                      ),
                  ],
                ),

              const SizedBox(height: 20.0), // Added space between password and username fields

              // Username TextField - shown only if password is valid
              if (_isPasswordValid)
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Enter your Username*',
                    border: OutlineInputBorder(),
                  ),
                ),

              const SizedBox(height: 16.0),

              // Continue Button
              if (_isPasswordValid)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(username: _usernameController.text),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Sign me up'),
                ),

              const SizedBox(height: 16.0),

              // Back to login option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
