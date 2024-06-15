import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_crud/firebase_options.dart';
import 'package:todo_crud/pages/Edit.dart';
import 'package:todo_crud/pages/Home.dart';
import 'package:todo_crud/pages/Signup.dart';
import 'package:todo_crud/pages/login.dart';
import 'pages/Add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login': (context) => login(),
        'Signup': (context)=> Signup(),
        'home': (context)=> Home(),
        'Edit': (context)=> Edit(),
        'Add' : (context)=> Add()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: login()
    );
  }
}

