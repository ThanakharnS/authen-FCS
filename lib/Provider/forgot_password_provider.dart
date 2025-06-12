

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPageProvider extends ChangeNotifier {

  final emailController = TextEditingController();

  Future<void> sendResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('ส่งอีเมลรีเซ็ตรหัสผ่านเรียบร้อย');
    } catch (e) {
      print('เกิดข้อผิดพลาด: $e');
    }
  }




}