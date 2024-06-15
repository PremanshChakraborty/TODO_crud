import 'package:cloud_firestore/cloud_firestore.dart';
class Notedata {

  String title;
  String body;
  String id;
  Notedata({required this.title,required this.body,required this.id});

  static Notedata tonote(DocumentSnapshot<Map<String,dynamic>> snapshot){
    return Notedata(title: snapshot['title'], body: snapshot['body'], id: snapshot['id']);

  }
}