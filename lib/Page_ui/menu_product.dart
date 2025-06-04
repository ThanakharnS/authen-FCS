

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuProductPage extends StatefulWidget {
  const MenuProductPage({super.key});

  @override
  _MenuProductPageState  createState() => _MenuProductPageState();
}



class _MenuProductPageState  extends State<MenuProductPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'menu_product'.tr(),
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
    );
  }


}