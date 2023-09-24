import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';


class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
      @override
      final _emailController = TextEditingController();
      final _passwordController = TextEditingController();
      bool _showPassword = false;
      String? errorCode;

      Future<String?> signInWithEmailAndPassword(
          String email, String password) async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          return null; // Sign-in successful
        } catch (e) {
          if (e is FirebaseAuthException) {
            return e.message; // Return the Firebase error message
          } else {
            return 'An unknown error occurred'; // Handle other exceptions
          }
        }
      }

      void _togglevisibility() {
        setState(() {
          _showPassword = !_showPassword;
        });
      }

      bool _isValidEmail(String email) {
        return EmailValidator.validate(email);
      }

        Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: const Text('Welcome in ToDoList', style: TextStyle(color: Colors.white),),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.deepOrangeAccent),
              leading: Image.asset('lib/logo/logo.png', width: 2, height: 2, scale: 1),
            ),


            body: Column(
              children: [
                const Padding(padding: EdgeInsets.all(40),),
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

                const Padding(padding: EdgeInsets.all(10),),

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

                const Padding(padding: EdgeInsets.all(10),),

                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 100, top: 10),),

                    ElevatedButton(
                      onPressed: () async {
                        errorCode = await signInWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text);
                        if(errorCode == null) {
                          Navigator.pushReplacementNamed(context, '/todo');
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(errorCode!),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context, '/');
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                      },
                      child: const Text('Sign in', style: TextStyle(fontSize: 15)),

                    ),

                    const Padding(padding: EdgeInsets.only(left: 20),),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/registration');
                      },
                      child: const Text('Registration', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                )
              ],
            )
        );
      }
}
