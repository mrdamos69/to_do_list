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
  final _nameController = TextEditingController();
  final double _buttonSize = 15;
  final double _buttonPadding = 5;
  bool _showPassword = false;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _registration (String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
                  icon: Icon(Icons.email_outlined, color: Colors.lightBlue,)
              ),
              style: const TextStyle(color: Colors.lightBlue),
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
                  color: Colors.lightBlue,
                ),
              ),
              style: const TextStyle(color: Colors.lightBlue),

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
                  color: Colors.lightBlue,
                ),
                suffixIcon: GestureDetector(
                  onTap: _togglevisibility,
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons
                          .visibility_off, color: Colors.white24),
                ),
              ),
              style: const TextStyle(color: Colors.lightBlue),
            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: "Repeat your password",
                hintStyle: const TextStyle(color: Colors.white12),
                labelStyle: const TextStyle(color: Colors.white54, ),
                border: InputBorder.none,
                icon: const Icon(
                  Icons.password,
                  color: Colors.lightBlue,
                ),

                suffixIcon: GestureDetector(
                  onTap: _togglevisibility,
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons
                          .visibility_off, color: Colors.white24
                  ),

                ),
              ),
              style: const TextStyle(color: Colors.lightBlue),
            ),

            Padding(padding: EdgeInsets.all(_buttonPadding),),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 100, top: 10),),
                ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('You are successfully registered'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  _registration(_emailController.text, _passwordController.text,);
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text('Ok'),
                            ),
                          ],
                        );
                      }
                    );
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
