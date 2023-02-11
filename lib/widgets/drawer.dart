import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../componets/app_collors.dart';
import '../componets/text.dart';
import '../views/home_Screen.dart';
import '../views/verify_screen.dart';

class TdDrawer extends StatelessWidget {
  const TdDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(child: SizedBox(height: height * 0.2,width: 100,child: Image.asset("assets/logo.png",fit: BoxFit.cover,))
            ),
             ListTile(
               onTap: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
               },
               title: CommonText(text: "Home"),
               leading: Icon(FluentIcons.home_24_regular),
               focusColor: Colors.amber,
             ),
             ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("user");
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyScreen(),)));
              },
              title: CommonText(text: "LogOut"),
              leading: Icon(FluentIcons.door_arrow_right_20_regular),
              focusColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
