import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServ{
  final _auth = FirebaseAuth.instance;
  
  
  Future <void> signOut()async{
    return await _auth.signOut();
  }
}