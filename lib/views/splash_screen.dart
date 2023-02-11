import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskel_app/views/verify_screen.dart';

import 'home_Screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? user = sharedPreferences.getString("user");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => user!= null ? HomeScreen() : VerifyScreen(),) );
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300,width: 300,child: Image.asset("assets/logo.png",fit: BoxFit.cover,))
          ],
        ),
      ),
    );
  }
}
