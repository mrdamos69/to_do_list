import 'package:flutter/material.dart';

    class MainScreen extends StatelessWidget {
      const MainScreen({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: Text('Список дел', style: TextStyle(color: Colors.white),),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Text('MainScreen',style: TextStyle(color: Colors.white),),
                ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/todo');
                      // Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
                      Navigator.pushReplacementNamed(context, '/todo');
                    },
                    child: Text('Перейти далее'))
              ],
            )
        );
      }
    }
