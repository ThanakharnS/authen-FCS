import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuHistoryPage extends StatefulWidget {
  const MenuHistoryPage({super.key});

  @override
  _MenuHistoryPageState createState() => _MenuHistoryPageState();
}

class _MenuHistoryPageState extends State<MenuHistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'menu_history'.tr(),
        style: GoogleFonts.kanit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );


  }

}
