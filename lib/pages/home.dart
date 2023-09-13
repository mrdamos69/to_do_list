import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  bool checkAdd = false;
  List todoList = [];

  @override

  void initState() {
    super.initState();
    todoList.addAll(['Купить огурцы','Купить молоко','Купить хлеб']);
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
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
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
                setState(() {
                  todoList.removeAt(index);
                });
              },
            );
          }
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
                          if(checkAdd) {
                            setState(() {
                              todoList.add(_userToDo);
                            });
                            Navigator.of(context).pop();
                            checkAdd = false;
                          }
                          // if(checkAdd) {
                          //   FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                          //   Navigator.of(context).pop();
                          //   checkAdd = false;
                          // }
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

