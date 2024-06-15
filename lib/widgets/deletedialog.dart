import 'package:flutter/material.dart';

Future<String?> deletedialog(String title,BuildContext context) async{
  return showDialog<String>(
    context: context,
    builder: (BuildContext context)=> AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Delete note "$title" ?'),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text('cancel')),
        TextButton(onPressed: ()=>Navigator.pop(context,'delete'), child: Text('Confirm')),
      ],
    )
  );
}