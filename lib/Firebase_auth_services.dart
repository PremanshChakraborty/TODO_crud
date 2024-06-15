


import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> signUpWithEmailAndPassword(String email, String password,) async {
    try{

      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    on FirebaseAuthException catch (e) {
      if(e.code=='invalid-email'){
        Fluttertoast.showToast(msg: 'Invalid Email');
        return 'Invalid Email';
      }
      if(e.code=='email-already-in-use'){
        Fluttertoast.showToast(msg: 'email address is already in use.');
        return 'Email already in use';
      }
      if(e.code=='weak-password'){
        Fluttertoast.showToast(msg: 'Weak password');
        return 'Weak Password';
      }
      else{
        Fluttertoast.showToast(msg: 'some error occurred ${e.code}');
        return null;
      }

    }
  }

  Future<dynamic> loginWithEmailAndPassword(String email, String password) async {
    try{

      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    on FirebaseAuthException catch (e) {
      if(e.code=='invalid-email'){
        Fluttertoast.showToast(msg: 'Invalid Email');
        return 'Invalid Email';
      }
      if(e.code=='invalid-credential'){
        Fluttertoast.showToast(msg: 'Invalid Credentials');
        return 'Invalid Credentials';
      }
      else{
        Fluttertoast.showToast(msg: 'some error occurred ${e.code}');
        return null;
      }
    }
  }
}