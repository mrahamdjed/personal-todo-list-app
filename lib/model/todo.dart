class Todo {

  String task;
  String id;
  bool done;
  bool delete;
  

  Todo({ required this.id , required this.task , this.done=false , this.delete=false });

  static List todos = <Todo>[
    
    // Todo(task: "m 1",delete: false),
    // Todo(task: "m 2",delete: false),
    // Todo(task: "m 3",delete: false),
    // Todo(task: "f 4",delete: false),
  ];


}