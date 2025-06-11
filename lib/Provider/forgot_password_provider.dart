

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPageProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isNewPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<String?> updatePassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      return "รหัสผ่านไม่ตรงกัน";
    }

    try {
      final user = _auth.currentUser;
      if (user != null && user.email == email.trim()) {
        await user.updatePassword(newPassword);
        return null; // success
      } else {
        return "ผู้ใช้ยังไม่ได้ล็อกอิน หรืออีเมลไม่ตรง";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "เกิดข้อผิดพลาด: $e";
    }
  }



  void toggleNewPasswordVisibility() {
    isNewPasswordObscured = !isNewPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

}