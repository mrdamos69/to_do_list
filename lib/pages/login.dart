import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
      @override
      bool _showPassword = false;
      String _email = "";

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
              title: Text('Welcome in ToDoList', style: TextStyle(color: Colors.white),),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
            ),


            body: Column(
              children: [
                Padding(padding: EdgeInsets.all(40),),
                TextFormField(
                    // controller: _controller,
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

                Padding(padding: EdgeInsets.all(10),),

                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !_showPassword,
                    decoration: InputDecoration(
                        labelText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.white12),
                        labelStyle: TextStyle(color: Colors.white54, ),
                        border: InputBorder.none,
                        icon: Icon(
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

                Padding(padding: EdgeInsets.all(10),),

                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 100, top: 10),),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/todo');
                        // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
                        Navigator.pushReplacementNamed(context, '/todo');
                      },
                      child: Text('Login', style: TextStyle(fontSize: 15)),

                    ),
                    const Padding(padding: EdgeInsets.only(left: 20),),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/registration');
                      },
                      child: Text('Registration', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                )
              ],
            )
        );
      }
}
