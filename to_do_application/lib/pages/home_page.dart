import 'package:flutter/material.dart';
import 'package:to_do_application/util/todo_tile.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar:AppBar(
        title:Text('To Do List') ,
        backgroundColor:Colors.yellow[600],
        elevation: 0,
      ),
      body: ListView(
        children: [
         TodoTile(
          taskName: "Make Tutorial",
          taskCompleted: false,
          onChanged: (p0){

          },
         ),

        ],
      ),
    );
  }
}