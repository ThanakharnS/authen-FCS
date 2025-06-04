

import 'package:flutter/material.dart';
import 'package:verify_identity/Page_ui/menu_history.dart';
import 'package:verify_identity/Page_ui/menu_main.dart';
import 'package:verify_identity/Page_ui/menu_product.dart';
import 'package:verify_identity/Page_ui/menu_profile.dart';

class HomePageProvider extends ChangeNotifier {

  bool loading = false;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;


  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> load() async{
    loading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2)); // simulate loading

    loading = false;
    notifyListeners();
  }

  final List<Widget> pages = [
    MenuProductPage(),
    MenuMainPage(),
    MenuHistoryPage(),
    MenuProfilePage(),
  ];


}