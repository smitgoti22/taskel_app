import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskel_app/views/verify_screen.dart';

import '../componets/button.dart';
import '../componets/text.dart';
import 'home_Screen.dart';

class OTPScreen extends StatefulWidget {
  String phonenum;
  OTPScreen({Key? key,required this.phonenum}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String ? OTP;

  int _counter = 30;
  Timer _timer = Timer(Duration(), () { });


  void _startTimer(){
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState((){
        if(_counter > 0)
        {
          _counter--;
        }
        else {
          _timer.cancel();
        }
      });
    });
  }
  Future verifyOtp()async{
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationCode!, smsCode: OTP.toString());
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: "Otp is Invalid")));
      // TODO
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _startTimer();
    _counter;
    _timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02,),
              SizedBox(height: height * 0.05,),
              CommonText(text: "OTP Verification",size: 20,color: Colors.black),
              SizedBox(height: height * 0.005,),
              CommonText(text: "We have sent the code verification to\nyour number ${widget.phonenum} Successfully",size: 14,color: Colors.grey),
              SizedBox(height: height * 0.02,),
              /// otp textfieald
              OtpTextField(
                onSubmit: (value) {
                  setState(() {
                    OTP = value;
                  });
                },
                numberOfFields: 6,
                focusedBorderColor: Colors.green,
              ),
              SizedBox(height: height * 0.04,),
              Align(child: Text(
                '00 : $_counter',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),),
              SizedBox(height: height * 0.03,),
              /// verify OTP
              CommonButton(
                ontap: () {
                  verifyOtp().then((value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("user",'login');
                  }
                  );
                },
                buttuonText: "Verify OTP",
                buttuonTextColor: Colors.white,
                color: Colors.green,
                iconColor: Colors.white,
              ),
              SizedBox(height: height * 0.02,),
              /// Back to Change Mobile Number
              CommonButton(
                ontap: () {
                  Navigator.pop(context);
                },
                buttuonText: "Change Mobile Number",
                buttuonTextColor: Colors.white,
                color: Colors.green,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
