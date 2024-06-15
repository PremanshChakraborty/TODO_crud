

import 'package:flutter/material.dart';
import 'package:todo_crud/widgets/deletedialog.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  Map data = {};


  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    TextEditingController titlecontroller = TextEditingController(text: data['title']);
    TextEditingController bodycontroller = TextEditingController(text: data['body']);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 5,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ) ,
        onPressed: () async {
          dynamic result = await deletedialog(titlecontroller.text, context);
          if(result=='delete'){
            Navigator.pop(context,{'title':titlecontroller.text,'body':bodycontroller.text,'save':false});
          }

        },
      ),
      appBar: AppBar(
      shadowColor: Colors.black,
      elevation: 5,
      title: TextField(
        style: TextStyle(
          fontSize: 20
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title'
        ),
        controller: titlecontroller,
      ),
      actions: [Padding(
        padding: const EdgeInsets.fromLTRB(0,0,12,0),
        child: IconButton(onPressed: (){
          Navigator.pop(context,{'title':titlecontroller.text,'body':bodycontroller.text,'save':true});
        }, icon: Icon(Icons.save_outlined,
        size: 32,),),
      )],
    ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: TextField(
              minLines: 25,
              maxLines: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              controller: bodycontroller,
            ),
          ),
        ),
    );
  }
}

