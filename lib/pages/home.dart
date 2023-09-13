import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  bool checkAdd = false;
  List<DocumentSnapshot<Object?>> todoList = [];

  @override

  void initState() {
    super.initState();
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(title: Text('Меню'),),
          body: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  },
                  child: Text('На главную')
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Наше простое меню')
            ],
          )
        );
      })
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _menuOpen,
              icon: Icon(Icons.menu_outlined)
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if(!snapshots.hasData) return Text('Нет записей');
          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshots.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshots.data!.docs[index].get('item')),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.lightBlue,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc(snapshots.data!.docs[index].id).delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction){
                    // if(direction == DismissDirection.endToStart) {
                    //   todoList.remove(index);
                    // } else if(direction == DismissDirection.startToEnd) {
                    //   todoList.removeAt(index);
                    // }
                    FirebaseFirestore.instance.collection('items').doc(snapshots.data!.docs[index].id).delete();
                  },
                );
              }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext) {
                return AlertDialog(
                  title: Text('Добавить элемент'),
                  content: TextField(
                    onChanged: (String value) {
                      checkAdd = true;
                      _userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          // if(checkAdd) {
                          //   setState(() {
                          //     todoList.add(_userToDo);
                          //   });
                          //   Navigator.of(context).pop();
                          //   checkAdd = false;
                          // }
                          if(checkAdd) {
                            FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                            Navigator.of(context).pop();
                            checkAdd = false;
                          }
                        },
                        child: Text('Добавить')
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add_box, color: Colors.white,),
      ),
    );
  }
}

