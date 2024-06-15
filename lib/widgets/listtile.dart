import 'package:flutter/material.dart';
import 'deletedialog.dart';
class listtile extends StatelessWidget {
  const listtile({required this.id,required this.title,required this.body,required this.savenote,required this.deletenote,super.key,});
  final String title;
  final String body;
  final Function savenote;
  final Function deletenote;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,10,0,10),
      child: ListTile(
        onTap: () async{
          dynamic result = await Navigator.pushNamed(context, 'Edit',arguments: {'title' : title,'body' : body});
          result['save']?savenote(result,id):deletenote(id);
        },
        title: Text(title,
        style: TextStyle(
          fontSize: 24
        ),),
        trailing: IconButton(
          onPressed: ()async {
            dynamic result = await deletedialog(title, context);
            if(result=='delete'){deletenote(id);}
            },
          icon: Icon(Icons.delete,
          color: Colors.grey[500],
          size: 32,),
        ),
      ),
    );
  }
}

