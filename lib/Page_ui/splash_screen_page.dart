



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verify_identity/Provider/splash_creen_provider.dart';

class  SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState  createState() => _SplashScreenPageState();

 }

class _SplashScreenPageState  extends State<SplashScreenPage> {
  
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<SplashScreenProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
         appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text('Verify Identity'),
            ),

        body: Center(child: Text('Test!!!!'),),
    );
  }
}





