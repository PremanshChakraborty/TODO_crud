import 'package:flutter/material.dart';

Future<String?> signoutdialog(BuildContext context) async{
  return showDialog<String>(
      context: context,
      builder: (BuildContext context)=> AlertDialog(
        title: Text('Signout'),
        content: Text('Signout from TODOcrud ?'),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: Text('cancel')),
          TextButton(onPressed: ()=>Navigator.pop(context,'Signout'), child: Text('Confirm')),
        ],
      )
  );
}