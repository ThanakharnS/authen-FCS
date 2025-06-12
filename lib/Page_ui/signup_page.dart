


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/signup_provider.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});
  
  @override
  _SignUpPageState createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpPageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'SignUp Account',
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
                  'กรอก  Email & Password',
                  style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Email field
                TextField(
                  controller: provider.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email:',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: provider.passwordController,
                  obscureText: provider.isNewPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'Password :',
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

                const SizedBox(height: 80),

                ElevatedButton(
                  onPressed: () async {
                    final email = provider.emailController.text.trim();
                    final password = provider.passwordController.text.trim();

                    if(email.isEmpty || password.isEmpty ){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('กรุณากรอกอีเมลและรหัสผ่าน')),
                      );
                      return;
                    }

                    final success = await provider.signUp(email, password);

                    if (success) {
                      provider.emailController.clear();
                      provider.passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('สร้างบัญชีสำเร็จ')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(provider.error ?? 'สมัครไม่สำเร็จ')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    'Sign Up',
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