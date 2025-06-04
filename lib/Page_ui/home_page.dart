
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState  createState() => _HomePageState();
}

class _HomePageState  extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = Provider.of<HomePageProvider>(context, listen: false);
      provider.changeIndex(0);
      await provider.load();
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'app_name'.tr(),
            style: GoogleFonts.kanit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          bodyHomePage(provider),
          if (provider.loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),

      // button
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedIndex,
        selectedItemColor: Colors.blueGrey,    // สี icon + label เมื่อถูกเลือก
        unselectedItemColor: Colors.blueGrey,  // สี icon + label เมื่อไม่ถูกเลือก

        selectedLabelStyle: GoogleFonts.kanit(
          fontWeight: FontWeight.normal,
        ),
        unselectedLabelStyle: GoogleFonts.kanit(),
        onTap: provider.changeIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance , color: Colors.blueGrey), label: 'menu_product'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.home ,color: Colors.blueGrey), label: 'menu_main'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.history ,color: Colors.blueGrey), label: 'menu_history'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.person ,color: Colors.blueGrey), label: 'menu_profile'.tr()),
        ],
      ),

    );
  }

  Widget bodyHomePage(HomePageProvider provider) {
    return Column(
      children: [
        Expanded(
          child: provider.pages[provider.selectedIndex],
        ),
      ],
    );


  }

  @override
  void dispose() {

    super.dispose();
  }
}
