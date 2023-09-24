import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _nameController = TextEditingController();
  final double _buttonSize = 15;
  final double _buttonPadding = 5;
  bool _showPassword = false;
  String? errorCode;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<String?> registerWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Registration successful
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e.message; // Return the Firebase error message
      } else {
        return 'An unknown error occurred'; // Handle other exceptions
      }
    }
  }

  bool _checkPassword() {
    if(_passwordController.text == _passwordCheckController.text) {
      return true;
    } else {
      return false;
    }
  }

  bool _isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Registration in ToDoList', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          leading: Image.asset('lib/logo/logo.png', width: 2, height: 2, scale: 1),
        ),

        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.white12),
                  labelStyle: TextStyle(color: Colors.white54),
                  icon: Icon(Icons.email_outlined, color: Colors.orange,)
              ),
              style: const TextStyle(color: Colors.orange),
              validator: (value) {_isValidEmail(value.toString());},
            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                hintStyle: TextStyle(color: Colors.white12),
                labelStyle: TextStyle(color: Colors.white54, ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.orange,
                ),
              ),
              style: const TextStyle(color: Colors.orange),

            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: "Enter your password",
                hintStyle: const TextStyle(color: Colors.white12),
                labelStyle: const TextStyle(color: Colors.white54, ),
                border: InputBorder.none,
                icon: const Icon(
                  Icons.password,
                  color: Colors.orange,
                ),
                suffixIcon: GestureDetector(
                  onTap: _togglevisibility,
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons
                          .visibility_off, color: Colors.white24),
                ),
              ),
              style: const TextStyle(color: Colors.orange),
            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              controller: _passwordCheckController,
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: "Repeat your password",
                hintStyle: const TextStyle(color: Colors.white12),
                labelStyle: const TextStyle(color: Colors.white54, ),
                border: InputBorder.none,
                icon: const Icon(
                  Icons.password,
                  color: Colors.orange,
                ),

                suffixIcon: GestureDetector(
                  onTap: _togglevisibility,
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons
                          .visibility_off, color: Colors.white24
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.orange),
            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 100, top: 10),),
                ElevatedButton(
                  onPressed: () async {
                    if(_checkPassword()) {
                      errorCode = await registerWithEmailAndPassword(
                          _emailController.text, _passwordController.text);
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    errorCode == null ?
                                    Navigator.pushReplacementNamed(context, '/') :
                                    Navigator.pushReplacementNamed(context, '/registration');
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                              title: Text(errorCode == null ? 'Registration completed successfully' : errorCode!),
                            );
                          }
                      );
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/registration');
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                              title: const Text('Password mismatch'),
                            );
                          }
                      );
                    }
                  },
                  child: Text('Registration', style: TextStyle(fontSize: _buttonSize)),

                ),
                const Padding(padding: EdgeInsets.only(left: 20),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Back', style: TextStyle(fontSize: _buttonSize)),
                ),
              ],
            ),
          ],
        )
    );
  }
}
