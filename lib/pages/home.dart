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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел', style: TextStyle(color: Colors.white),),
        centerTitle: true,
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

