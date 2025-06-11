

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  void handleResetPassword() async {
    final provider = Provider.of<ForgotPasswordPageProvider>(context, listen: false);
    final result = await provider.updatePassword(
      email: provider.emailController.text.trim(),
      newPassword: provider.newPasswordController.text.trim(),
      confirmPassword: provider.confirmPasswordController.text.trim(),
    );

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('dialog_massage_success'.tr())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

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

                // Email field
                TextField(
                  controller: provider.emailController,
                  decoration: InputDecoration(
                    labelText: 'label_txt_input_email'.tr(),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: provider.newPasswordController,
                  obscureText: provider.isNewPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'txt_input_password'.tr(),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        provider.isNewPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: provider.toggleNewPasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: provider.confirmPasswordController,
                  obscureText: provider.isConfirmPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'confirm_txt_input_password'.tr(),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        provider.isConfirmPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: provider.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                ElevatedButton(
                  onPressed: handleResetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    'bnt_submit_change'.tr(),
                    style: GoogleFonts.kanit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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