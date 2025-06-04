

 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuProfileProvider extends ChangeNotifier{

 final FirebaseAuth _auth = FirebaseAuth.instance;

 User? get currentUser => _auth.currentUser;

 // Logout
 Future<void> signOut() async {
  await _auth.signOut();
  print('---> Log Out!!!');
  notifyListeners();
 }


 bool get isLoggedIn => _auth.currentUser != null;

}
