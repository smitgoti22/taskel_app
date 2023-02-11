import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskel_app/views/splash_screen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: SplashScreen());
  }
}
