

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/menu_profile_provider.dart';
import 'login_page.dart';


class MenuProfilePage extends StatefulWidget {
  const MenuProfilePage({super.key});

  @override
  _MenuProfilePageState  createState() => _MenuProfilePageState();
}

class _MenuProfilePageState  extends State<MenuProfilePage> {

  @override
  Widget build(BuildContext context) {

    final menuProfileProvider = Provider.of<MenuProfileProvider>(context, listen: false);


    return Scaffold(
        backgroundColor: Colors.grey[100],
      body: SafeArea(
           child: Column(
             children: [
           // ส่วนโปรไฟล์ด้านบน
             Container(
             padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
             color: Colors.grey[100],
             child: Column(
               children: [
                 // รูปโปรไฟล์
                 CircleAvatar(
                   radius: 50,
                   backgroundImage: AssetImage('assets/image/img_profile.png'),
                 ),
                 const SizedBox(height: 20),
                 // ข้อมูลผู้ใช้
                   Column(
                     children: [
                       Text(
                         'name_profile'.tr(),
                         style: GoogleFonts.kanit(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       const SizedBox(height: 4),
                       Text(
                         'email_profile'.tr(),
                         style: GoogleFonts.kanit(
                           fontSize: 14,
                           color: Colors.grey[600],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
               const SizedBox(height: 20),
               Expanded(
                   child: ListView(
                     children: [
                       profileMenuItem(
                         icon: Icons.edit,
                         title: 'func_edite_profile'.tr(),
                         onTap: () {
                           // TODO: ไปหน้าแก้ไข
                         },
                       ),
                       profileMenuItem(
                         icon: Icons.lock,
                         title: 'func_chang_password'.tr(),
                         onTap: () {
                           // TODO: ไปหน้าเปลี่ยนรหัส
                         },
                       ),
                       profileMenuItem(
                         icon: Icons.history,
                         title: 'func_history'.tr(),
                         onTap: () {
                           // TODO: ไปหน้าประวัติ
                         },
                       ),
                       profileMenuItem(
                         icon: Icons.logout,
                         title: 'func_sign_out'.tr(),
                         onTap: () async {
                           await menuProfileProvider.signOut();
                           if (!mounted) return; // ป้องกันการเรียก Navigator ถ้า widget ถูก dispose ไปแล้ว
                           Navigator.of(context).pushAndRemoveUntil(
                             MaterialPageRoute(builder: (context) => const LoginPage()),
                                 (route) => false,
                           );
                         },
                         color: Colors.red,
                       ),
                     ],
                   ),
               ),

           ],
         ),
       ),

    );

  }

  Widget profileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.kanit(
          fontSize: 16,
          color: color,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}