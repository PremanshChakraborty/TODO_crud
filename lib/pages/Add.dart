

import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  Map data = {};


  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    TextEditingController titlecontroller = TextEditingController(text: data['title']);
    TextEditingController bodycontroller = TextEditingController(text: data['body']);


    return Scaffold(
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
            Navigator.pop(context,{'title':titlecontroller.text,'body':bodycontroller.text});
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

