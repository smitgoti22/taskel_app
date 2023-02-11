import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Firebase_Service/google_auth_service.dart';
import '../componets/button.dart';
import '../componets/text.dart';
import '../componets/textfieald.dart';
import 'home_Screen.dart';
import 'otp_screen.dart';


class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

String ? verificationCode;

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future sendOtp()async{
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (phoneAuthCredential) {
      }, verificationFailed: (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: error.message)));
    }, codeSent: (verificationId, forceResendingToken) {
      verificationCode = verificationId;
    }, codeAutoRetrievalTimeout: (verificationId) {

    },);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(text: "Taskel", color: Colors.green, size: 36),
                SizedBox(
                  height: height * 0.005,
                ),
                const CommonText(
                    text: "Make Tasks and achive Goals!",
                    color: Colors.grey,
                    size: 14),
                SizedBox(
                  height: height * 0.05,
                ),

                /// phone number textfieald
                CommonTextfieald(
                  controller: phoneController,
                  keyboardtype: TextInputType.phone,
                  borderradious: 5,
                  prefixicon:
                      Icon(FluentIcons.phone_arrow_right_24_regular, size: 31),
                  inputformatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (value.length != 10) {
                        return "Please Enter 10 Digits";
                      } else {
                        return null;
                      }
                    } else {
                      return "Mobile Number cannot be Empty!";
                    }
                  },
                  hinttext: "Phone no.",
                ),

                /// Continue button
                SizedBox(height: height * 0.03),
                CommonButton(
                  buttuonText: "Continue",
                  buttuonTextColor: Colors.white,
                  ontap: () {
                    if (formkey.currentState!.validate()) {
                      sendOtp().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(phonenum: phoneController.text,),
                          )));
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                /// countinue with
                const CommonText(text: "Countinue with", color: Colors.grey),
                SizedBox(
                  height: height * 0.02,
                ),

                /// google button
                CommonButton(
                  buttuonText: "Google",
                  buttuonTextColor: Colors.white,
                  isIcon: true,
                  icon: Ionicons.logo_google,
                  color: Colors.red,
                  iconColor: Colors.white,
                  ontap: () {
                    GetGoogleAuthService.signInWithGoogle().then((value) async {
                      if(value != null)
                        {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("user",'login');
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen(),));
                        }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: "Something Went Wrong")));
                      }
                    });
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}
