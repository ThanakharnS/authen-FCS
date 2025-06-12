

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:verify_identity/Provider/forgot_password_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState  createState() => _ForgotPasswordPageState();
}


class _ForgotPasswordPageState  extends State<ForgotPasswordPage> {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ForgotPasswordPageProvider>(context);

    return Scaffold(
       backgroundColor: Colors.blueGrey,
       appBar: AppBar(
         backgroundColor: Colors.white,
         centerTitle: true,
         title: Text(
           'header_txt_forgot_password'.tr(),
           style: GoogleFonts.kanit(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: Colors.blueGrey,
           ),
         ),
       ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'header_txt_reset_password'.tr(),
                  style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: provider.emailController,
                  decoration: InputDecoration(
                    labelText: 'label_txt_input_email'.tr(),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 60),

                ElevatedButton(
                  onPressed: () async {
                    final email = provider.emailController.text.trim();
                    if (email.isNotEmpty) {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      provider.emailController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ส่งลิงก์รีเซ็ตรหัสผ่านไปยังอีเมลแล้ว')),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('กรุณากรอก อีเมล!!!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'bnt_submit_change'.tr(),
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}