import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../widgets/item.dart';
import '../model/todo.dart';



class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}



class _ScreenState extends State<Screen> {

  List currentTodos = Todo.todos;

  final newItemController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: tdBGColor,
      
      appBar: _buildAppBar(),
      
      body: Stack(children: [
        
        Column(children: [

          _buildSearchBar(),
        
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(20),
        
            children: [
        
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                child: const Text(
                  "All ToDos",
                  style: TextStyle(
                      color: tdBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              
              for (Todo todo in currentTodos) _buildSingleItem(todo),
            
            ],
          ))
        ]),

        Align(alignment: Alignment.bottomCenter, child: _addItem()),
      
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          "Personal ToDo",
          style: TextStyle(
              color: tdBlack, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/photo.jpg"),
          ),
        )
      ]),
      backgroundColor: tdBGColor,
    );
  }

  void _searchListHandling(String inputt){
    if(inputt.isEmpty){
      currentTodos = Todo.todos;
    }
    else{
      List x = <Todo>[];

      for(Todo todo in Todo.todos){

        if(todo.task.toLowerCase().contains(inputt.toLowerCase())){
          x.add(todo);
        }
      }
      currentTodos = x;
    }

    setState(() {});
  
  }
  
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child:TextField(
        onChanged: (value) { 
          _searchListHandling(value);
        },
        decoration: const InputDecoration(
            icon: Icon(
              Icons.search_rounded,
              color: tdBlack,
            ),
            hintText: "Search",
            border: InputBorder.none),
      ),
    );
  }

  void _deleteItem(Todo todo) {
    Todo.todos.removeWhere((item) => item.id == todo.id);
    setState(() {});
  }

  Widget _buildSingleItem(Todo todo) {
    if (todo.delete == false) {
      return ToDoItem(
        todo: todo,
        deleteFunc: _deleteItem,
      );
    }

    return const SizedBox();
  }

  void _newItem(String task){
    Todo.todos.add(Todo(id : DateTime.now().millisecondsSinceEpoch.toString() , task: task));
  }
  Widget _addItem() {
    
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
  
      child: Row(
  
        children: [
  
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(spreadRadius: 0.1, blurRadius: 5)
                  ]),
              
              child: TextField(
                controller: newItemController,
                  decoration: const InputDecoration(
                      hintText: "Add a new todo item",
                      border: InputBorder.none)),
            ),
          ),
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: tdBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  if(newItemController.text.isNotEmpty){
                    _newItem(newItemController.text);
                    newItemController.clear();
                  }
                  setState(() {});
                },
              )),
        ],
      ),
    );
  }


}
