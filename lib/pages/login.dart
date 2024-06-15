import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_crud/Firebase_auth_services.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late bool _obscureText;
  final _formkey= GlobalKey<FormState>();
  bool _islogin= false;
  String? emailerror= null;
  String? passworderror= null;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController passwordcontroller= TextEditingController();

  @override
  void dispose() {
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
        title: Text('login',
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
              ElevatedButton(onPressed:  _login,
                  child: Center(child: _islogin? CircularProgressIndicator(color: Colors.grey[200],):Text('Login',
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
                  children: [Text('Dont have an account?'),
                    GestureDetector(
                      child: Text('Signup',
                        style: TextStyle(
                          color: Colors.blue,
                        ),),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,'Signup',(route) => false );
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
  void _login() async {

    if (_formkey.currentState!.validate()) {
      setState(() {
        _islogin = true;
      });
      String email = emailcontroller.text;
      String password = passwordcontroller.text;

      dynamic user = await _auth.loginWithEmailAndPassword(email, password);
      setState(() {
        _islogin = false;
      });
      if (user == 'Invalid Email') {
        emailerror = user;
        _formkey.currentState!.validate();
      }
      else if (user == 'Invalid Credentials') {
        emailerror = user;
        passworderror = user;
        _formkey.currentState!.validate();
      }
      else if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, 'home', (route) => false, arguments: user.uid);
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
