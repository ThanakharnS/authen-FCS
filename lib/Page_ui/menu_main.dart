

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuMainPage extends StatefulWidget {
  const MenuMainPage({super.key});

  @override
  _MenuMainPageState  createState() => _MenuMainPageState();
}



class _MenuMainPageState  extends State<MenuMainPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'menu_main'.tr(),
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
    );
  }


}