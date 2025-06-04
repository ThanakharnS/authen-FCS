
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verify_identity/Provider/login_provider.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
 }

 class _LoginPageState extends State<LoginPage> {

   void _signIn(BuildContext context) async {

     final provider = Provider.of<LoginProvider>(context, listen: false);

     provider.error = null;
     provider.loading = true;

     final email = provider.emailController.text.trim();
     final pass = provider.passwordController.text.trim();

     final errorMessage = await provider.signIn(email, pass);

     provider.loading = false;

     if (errorMessage == null) {
       if (!context.mounted) return;
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (_) => HomePage()),
       );
     } else {
       provider.error = errorMessage;
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             content: Text(
                 'error_massage_login'.tr(),
               style: GoogleFonts.kanit(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Colors.blueGrey,
               ),
             ),
         ),
       );
     }
   }

   Widget bodyLoginPage(LoginProvider provider) {
     return Stack(
       children: [
         Positioned(
           top: 40,
           right: 24,
           child: PopupMenuButton<String>(
             onSelected: (String value) {
              // provider.changeLanguage(value);
               context.setLocale(Locale(value));
             },
             icon:  Icon(
               Icons.language,
               color: Colors.white,
               weight: 36,
             ),
             itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                    value: 'en',
                    child: Text(
                        'English',
                      style: GoogleFonts.kanit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                ),
                PopupMenuItem(
                    value: 'th',
                    child: Text(
                        'ไทย',
                      style: GoogleFonts.kanit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                ),
             ],
           ),
         ),

         // เนื้อหา login card อยู่ตรงกลาง
         Center(
           child: SingleChildScrollView(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
             child: Card(
               elevation: 10,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),
               ),
               child: Container(
                 padding: const EdgeInsets.all(24),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   gradient: LinearGradient(
                     colors: [Colors.white, Colors.grey.shade100],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                   ),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.2),
                       blurRadius: 10,
                       offset: const Offset(0, 4),
                     )
                   ],
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                      Text(
                       'welcome'.tr(),
                       style: GoogleFonts.kanit(
                         fontSize: 26,
                         fontWeight: FontWeight.bold,
                         color: Colors.blueGrey,
                       ),

                       textAlign: TextAlign.center,
                     ),
                     const SizedBox(height: 24),
                     TextField(
                       controller: provider.emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.email_outlined),
                         labelText: 'email'.tr(),
                         labelStyle: GoogleFonts.kanit(
                           fontSize: 16,
                           fontWeight: FontWeight.normal,
                           color: Colors.black,
                         ),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                     ),
                     const SizedBox(height: 16),
                     TextField(
                       controller: provider.passwordController,
                       obscureText: true,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.lock_outline),
                         labelText: 'password'.tr(),
                         labelStyle: GoogleFonts.kanit(
                           fontSize: 16,
                           fontWeight: FontWeight.normal,
                           color: Colors.black,
                         ),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                     ),
                     const SizedBox(height: 20),
                     if (provider.error != null)
                       Text(
                         provider.error!,
                         style: const TextStyle(color: Colors.red),
                         textAlign: TextAlign.center,
                       ),
                     const SizedBox(height: 10),
                     SizedBox(
                       height: 50,
                       child: ElevatedButton(
                         onPressed: provider.loading ? null : () => _signIn(context),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.white60,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                           ),
                         ),
                         child: provider.loading
                             ? const CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                         )
                             : Text(
                           'login'.tr(),
                           //style: TextStyle(fontSize: 16),
                           style: GoogleFonts.kanit(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.blueGrey,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 12),
                     TextButton(
                       onPressed: () {
                         // ไปหน้าสมัครสมาชิก
                       },
                       child: Text(
                         'forgot_password'.tr(),
                         style: GoogleFonts.kanit(
                           fontSize: 14,
                           fontWeight: FontWeight.normal,
                           color: Colors.blueGrey,
                         ),
                       ),
                     ),
                     TextButton(
                       onPressed: () {
                         // ไปหน้าสมัครสมาชิก
                       },
                       child: Text(
                           'sign_up'.tr(),
                         style: GoogleFonts.kanit(
                           fontSize: 14,
                           fontWeight: FontWeight.normal,
                           color: Colors.blueGrey,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ),
       ],
     );
   }

   Widget bodyLoginPage03(LoginProvider provider) {
     return Center(
       child: SingleChildScrollView(
         padding: const EdgeInsets.symmetric(horizontal: 24.0),
         child: Card(
           elevation: 10,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           child: Container(
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               gradient: LinearGradient(
                 colors: [Colors.white, Colors.grey.shade100],
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
               ),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.2),
                   blurRadius: 10,
                   offset: const Offset(0, 4),
                 )
               ],
             ),
             child: Stack(
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     const SizedBox(height: 16),
                     const Text(
                       "Welcome back!",
                       style: TextStyle(
                         fontSize: 26,
                         fontWeight: FontWeight.bold,
                         color: Colors.black87,
                       ),
                       textAlign: TextAlign.center,
                     ),
                     const SizedBox(height: 24),
                     TextField(
                       controller: provider.emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.email_outlined),
                         labelText: "Email",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                     ),
                     const SizedBox(height: 16),
                     TextField(
                       controller: provider.passwordController,
                       obscureText: true,
                       decoration: InputDecoration(
                         prefixIcon: const Icon(Icons.lock_outline),
                         labelText: "Password",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                     ),
                     const SizedBox(height: 20),
                     if (provider.error != null)
                       Text(
                         provider.error!,
                         style: const TextStyle(color: Colors.red),
                         textAlign: TextAlign.center,
                       ),
                     const SizedBox(height: 10),
                     SizedBox(
                       height: 50,
                       child: ElevatedButton(
                         onPressed: provider.loading ? null : () => _signIn(context),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.white60,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                           ),
                         ),
                         child: provider.loading
                             ? const CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                         )
                             : const Text(
                           "Login",
                           style: TextStyle(fontSize: 16),
                         ),
                       ),
                     ),
                     const SizedBox(height: 12),
                     TextButton(
                       onPressed: () {
                         // ไปหน้าสมัครสมาชิก
                       },
                       child: const Text("Don't have an account? Sign up"),
                     )
                   ],
                 ),
                 // Language toggle button at top-right
                 Align(
                   alignment: Alignment.topRight,
                   child: PopupMenuButton<String>(
                     onSelected: (String value) {
                       provider.changeLanguage(value); // implement this in your provider
                     },
                     icon: const Icon(Icons.language, color: Colors.black54),
                     itemBuilder: (BuildContext context) => [
                       const PopupMenuItem(value: 'en', child: Text('English')),
                       const PopupMenuItem(value: 'th', child: Text('ไทย')),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
     );
   }

   Widget bodyLoginPage02(LoginProvider provider) {
     return Center(
       child: SingleChildScrollView(
         padding: const EdgeInsets.symmetric(horizontal: 24.0),
         child: Card(
           elevation: 10,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           child: Container(
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               gradient: LinearGradient(
                 colors: [Colors.white, Colors.grey.shade100],
                 begin: Alignment.topLeft,
                 end: Alignment.bottomRight,
               ),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.2),
                   blurRadius: 10,
                   offset: const Offset(0, 4),
                 )
               ],
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 const Text(
                   "Welcome back!",
                   style: TextStyle(
                     fontSize: 26,
                     fontWeight: FontWeight.bold,
                     color: Colors.black87,
                   ),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 24),
                 TextField(
                   controller: provider.emailController,
                   keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                     prefixIcon: const Icon(Icons.email_outlined),
                     labelText: "Email",
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                   ),
                 ),
                 const SizedBox(height: 16),
                 TextField(
                   controller: provider.passwordController,
                   obscureText: true,
                   decoration: InputDecoration(
                     prefixIcon: const Icon(Icons.lock_outline),
                     labelText: "Password",
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20),
                 if (provider.error != null)
                   Text(
                     provider.error!,
                     style: const TextStyle(color: Colors.red),
                     textAlign: TextAlign.center,
                   ),
                 const SizedBox(height: 10),
                 SizedBox(
                   height: 50,
                   child: ElevatedButton(
                     onPressed: provider.loading
                      ? null
                     : () => _signIn(context),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white60,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12),
                       ),
                     ),
                     child: provider.loading
                         ? const CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                     )
                         : const Text(
                       "Login",
                       style: TextStyle(fontSize: 16),
                     ),
                   ),
                 ),
                 const SizedBox(height: 12),
                 TextButton(
                   onPressed: () {
                     // ไปหน้าสมัครสมาชิก
                   },
                   child: const Text("Don't have an account? Sign up"),
                 )
               ],
             ),
           ),
         ),
       ),
     );
   }

   @override
  void initState() {
     final provider = Provider.of<LoginProvider>(context, listen: false);
     provider.emailController.clear();
     provider.passwordController.clear();
     super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    if(screenWidth < 600 ){
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: bodyLoginPage(provider)
        ),
      );
    }else {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: bodyLoginPage(provider)
        ),
      );
    }

  }

    @override
    void dispose() {
      final provider = Provider.of<LoginProvider>(context, listen: false);
      provider.emailController.dispose();
      provider.passwordController.dispose();
      super.dispose();
    }
 }






