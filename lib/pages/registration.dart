import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  double _buttonSize = 15;
  double _buttonPadding = 5;
  bool _showPassword = false;
  String email = "";
  String password = "";
  String name = "";

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
          title: Text('Registration in ToDoList', style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),

        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
            ),
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

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
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

            Padding(padding: EdgeInsets.all(_buttonPadding),),

            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: "Repeat your password",
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

            Padding(padding: EdgeInsets.all(_buttonPadding),),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 100, top: 10),),
                ElevatedButton(
                  // onPressed: () {
                  //   Navigator.pushReplacementNamed(context, '/');
                  // },
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('You are successfully registered'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: Text('Ok'),
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
