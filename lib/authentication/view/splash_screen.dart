import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saga_kart_admin/authentication/provider/splash_provider.dart';
import 'package:saga_kart_admin/authentication/view/login_screen.dart';
import 'package:saga_kart_admin/core/storage_helper.dart';
import 'package:saga_kart_admin/dashboard/view/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    decideScreen();
    super.initState();
  }

  Future decideScreen() async {
    await Future.delayed(const Duration(seconds: 1),);
    SplashProvider splashProvider =
    Provider.of<SplashProvider>(context, listen: false);
    bool success = await splashProvider.checkLoggedIn();
    if (mounted) {
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const DashboardScreen();
          }),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const LogInScreen();
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SAGA SHOP KART',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
              ),
              Icon(Icons.shop, size: 40,)
            ],
          ),


        )
    );
  }
}
