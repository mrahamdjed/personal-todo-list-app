import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../model/todo.dart';



class ToDoItem extends StatefulWidget {
  final Todo todo;
  final deleteFunc;

  const ToDoItem({super.key , required this.todo , required this.deleteFunc });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 6),
      
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 10 ),
        onTap: () {
          widget.todo.done= !( widget.todo.done );
          setState(() {});
        },

        leading: _checkBox() ,
        title: _text(widget.todo.task, done: widget.todo.done ),
        trailing: _delete() ,
      
      ),
    );
  }

  Widget _text(String? data , {bool done = false} ){
    return Text( "$data" , style: TextStyle(fontSize: 16 , color: tdBlack , decoration: (done)? TextDecoration.lineThrough : null ) );
  }

  Widget _checkBox(){
    return IconButton(
      onPressed: (){
        widget.todo.done= !( widget.todo.done );
        setState(() {});
      },
      icon: Icon( (widget.todo.done)? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded  , color: tdBlue,)
    );
  }

  Widget _delete(){
    return Container(
          height: 35,
          width: 35,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: tdRed
          ),
          
          child: IconButton(
            icon: const Icon(Icons.delete_rounded ,
            size: 18, 
            color: Colors.white,),
            onPressed: () {
              widget.deleteFunc(widget.todo);
              setState(() {});  
            },
          ),
        );
  }
}