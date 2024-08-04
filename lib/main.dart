import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
 var todoController=TextEditingController();
    List arrTodo=[];

  @override
  Widget build(BuildContext context) {
   
    void addTodo(){
      if(todoController.text.isNotEmpty){
        setState(() {
           arrTodo.add(todoClass(title:todoController.text.toString()));
           todoController.clear();
        });
      }
    }
    void toggleCheckbox(int index){
      setState(() {
        arrTodo[index].isCompleted=!arrTodo[index].isCompleted;
      });
    }

    void removeList(int index){
      setState((){
        arrTodo.removeAt(index);
      });
    }
    return Scaffold(
      body:Container(
        color:Color.fromARGB(248, 255, 255, 255),
        child:Column(
          children: [
            Container(
             decoration: BoxDecoration(
               color: const Color.fromARGB(255, 157, 255, 0) ,
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0),bottomRight: Radius.circular(35.0))
              ),
             child:Column(children:[
              SizedBox(height:30 ,),
               Text(widget.title,style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color:const Color.fromARGB(255, 0, 75, 79) ),),
               SizedBox(height:26),
               Padding(
             padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 40.0),
             child: Container(
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:18.0),
                          child: TextField(
                            style: TextStyle(color:const Color.fromARGB(255, 96, 187, 0),fontWeight: FontWeight.bold),
                            controller: todoController,
                            decoration: InputDecoration(
                              hintText: 'Write your Todo',
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                  Container(
                   
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 0, 75, 79) ,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(overlayColor:Color.fromARGB(255, 233, 255, 196)),
                      onPressed: (){
                      addTodo();
                    }
                    , child: Text("Add",style: TextStyle(color:const Color.fromARGB(255, 200, 255, 142),fontWeight: FontWeight.bold,fontSize: 15),)),
                  )
                ],
              )
              ),
           ),
             ])
            ),
           Expanded(
             child: ListView.builder(
              itemCount: arrTodo.length,
              itemBuilder: (context,index){
                final task=arrTodo[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child:Card(
                elevation:3,
                color:const Color.fromARGB(255, 157, 255, 0),
                child: ListTile(
                  leading:Checkbox(
                    activeColor: const Color.fromARGB(255, 0, 75, 79) ,
                    value: task.isCompleted, 
                    onChanged:(value){
                     toggleCheckbox(index);
                    }
                    
                    ),
                  title:Text(task.title,
                  style: TextStyle(
                    color:const Color.fromARGB(255, 0, 75, 79),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    decoration:task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                    ),

                    ),
                  trailing:InkWell(
                    onTap:(){
                      removeList(index);
                    },
                    child:CircleAvatar(
                      backgroundColor:const Color.fromARGB(255, 255, 255, 255),
                      child: Icon(Icons.delete,color: const Color.fromARGB(255, 0, 75, 79))),
                  )
                ),
              )
              );
             },
             ),
           )
          ],
        )
      ),
      );
  }
}