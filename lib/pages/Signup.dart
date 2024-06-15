import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_crud/Firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  late bool _obscureText;
  final _formkey=GlobalKey<FormState>();
  bool _issignup=false;
  String? emailerror = null;
  String? passworderror = null;
  TextEditingController usernamecontroller= TextEditingController();
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller= TextEditingController();

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _obscureText = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.black,
        title: Text('Signup',
          style: TextStyle(
              color: Colors.grey[200]
          ),),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: TextFormField(
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'Username',
                      ),
                    )
                ),
                SizedBox( height: 15.0,),
                Container(
                    child: TextFormField(
                      validator: emailvalidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (string){
                        emailerror= null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'Email',
                      ),
                    )
                ),
                SizedBox( height: 15.0,),
                Container(
                    child: TextFormField(
                      validator: passwordvalidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (string){
                        passworderror= null;
                      },
                      controller: passwordcontroller,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon : Icon(_obscureText? Icons.visibility : Icons.visibility_off),
                          color: Colors.grey[600],
                          onPressed: () {setState(() {
                            _obscureText=!_obscureText;
                          });
                          },),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'Password',
                      ),
                    )
                ),
                SizedBox(height: 30),
                ElevatedButton(onPressed:  _signup,
                  child: Center(child: _issignup? CircularProgressIndicator(color: Colors.grey[200],):Text('Signup',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 20
                    ),)),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    fixedSize: MaterialStateProperty.all(Size(double.infinity, 60)),

                  ),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Already have an account?'),
                    GestureDetector(
                      child: Text('Login',
                        style: TextStyle(
                          color: Colors.blue,
                        ),),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,'Login',(route) => false );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _signup() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _issignup = true;
      });
      String username = usernamecontroller.text;
      String email = emailcontroller.text;
      String password = passwordcontroller.text;

      dynamic user = await _auth.signUpWithEmailAndPassword(email, password);
      setState(() {
        _issignup = false;
      });
      if (user == 'Invalid Email') {
        emailerror = user;
        _formkey.currentState!.validate();
      }
      else if (user == 'Email already in use') {
        emailerror = user;
        _formkey.currentState!.validate();
      }
      else if (user == 'Weak Password') {
        passworderror = user;
        _formkey.currentState!.validate();
      }
      else if (user != null) {
        Fluttertoast.showToast(msg: 'User created successfully');
        Navigator.pushNamedAndRemoveUntil(
            context, 'home', (route) => false, arguments: user.uid);
      }
      else {

      }
    }
  }
  String? emailvalidator(String? email){
    if(email==''){
      return 'Email Required';
    }
    return emailerror;
  }
  String? passwordvalidator(String? email){
    if(email==''){
      return 'Password Required';
    }
    return passworderror;
  }
}
