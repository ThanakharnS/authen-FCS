


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  String? error;

  final String _email = '';
  String get email => _email;
  final String _pass = '';
  String get password => _pass;


  Future<String?> signIn(String email, String password) async {
    try {

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      User? user = _auth.currentUser;
      print("✅ Login success: ${user?.email}");

      return null;
    } on FirebaseAuthException catch (e) {
      print("❌ Firebase error: ${e.message}");
      return e.message;
    } catch (e) {
      print("❌ Unexpected error: $e");
      return 'Unexpected error occurred: $e';
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> messageWarningSuccess() async {
    Fluttertoast.showToast(
      msg: "✅ Login success!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
    notifyListeners();
  }

  Future<void> messageWarningError() async {
    Fluttertoast.showToast(
      msg: "❌ Login Error",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    notifyListeners();
  }


  void changeLanguage(String lang) {
    // ใช้ context หรือ LocalizationProvider ในการเปลี่ยนภาษา
    print('===> lang : $lang');
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}