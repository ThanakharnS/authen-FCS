


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPageProvider extends ChangeNotifier {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isNewPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  String? error;


  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("สมัครสมาชิกสำเร็จ: ${userCredential.user?.uid}");
      error = null;
      return true;
    } on FirebaseAuthException catch (e) {
      // ตรวจรหัสข้อผิดพลาด
      if (e.code == 'email-already-in-use') {
        error = 'อีเมลนี้ถูกใช้ไปแล้ว';
      } else if (e.code == 'invalid-email') {
        error = 'อีเมลไม่ถูกต้อง';
      } else if (e.code == 'weak-password') {
        error = 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
      } else {
        error = 'เกิดข้อผิดพลาด: ${e.message}';
      }
      return false;
    } catch (e) {
      error = 'เกิดข้อผิดพลาดบางอย่าง';
      return false;
    }
  }









}