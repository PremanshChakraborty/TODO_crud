
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_crud/dataclasses/notedata.dart';
import 'package:todo_crud/widgets/listtile.dart';
import 'package:todo_crud/widgets/Signoutdialog.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)!.settings.arguments.toString();
    void savenote(dynamic result,String id){
      setState(() {
        final userCollection = FirebaseFirestore.instance.collection(uid);
        userCollection.doc(id).update({

          "id": id,
          "title": result['title'],
          "body": result['body'],
        });
      });
    }
    void deletenote(String id) {
      setState(() {
        final userCollection = FirebaseFirestore.instance.collection(uid);
        userCollection.doc(id).delete();
      });
    }
    void createnote(String title,String body,String uid){
      final userCollection = FirebaseFirestore.instance.collection(uid);
      String id = userCollection.doc().id;
      userCollection.doc(id).set({

        "id": id,
        "title": title,
        "body": body,
      });
    }
    Stream<List<Notedata>> readdata(String uid){
      final userCollection = FirebaseFirestore.instance.collection(uid);
      return userCollection.snapshots().map((querySnapshot) =>
      querySnapshot.docs.map((documentSnapshot) => Notedata.tonote(documentSnapshot)).toList());
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.black,
        title: Text('TODOcrud',
        style: TextStyle(
          color: Colors.grey[200]
        ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async {
            dynamic result = await signoutdialog(context);
            if(result=='Signout'){
              FirebaseAuth.instance.signOut();
              Fluttertoast.showToast(msg: 'Logout successful');
            Navigator.pushNamedAndRemoveUntil(context, 'Login', (route) => false);}

          }, icon: Icon(Icons.logout,color: Colors.grey[200],
          ))
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: StreamBuilder<List<Notedata>>(
        stream: readdata(uid),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(
              color: Colors.black,
            ),);
          }
          if(snapshot.data!.isEmpty){
            return Center(child: Text('No notes yet'));
          }
          final notes= snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context,index){
              return Card(
                child: listtile(title: notes[index].title,body: notes[index].body,savenote: savenote,deletenote: deletenote,id: notes[index].id,),
              );
            },
          
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          dynamic result = await Navigator.pushNamed(context, 'Add',arguments: {'title':'','body':''});
          if(result!=null){
            createnote(result['title'],result['body'],uid);
          }
        },
        backgroundColor: Colors.black,
        elevation: 5,
        child: Icon(Icons.add,
        color: Colors.white,),
      ),
    );
    }
}
