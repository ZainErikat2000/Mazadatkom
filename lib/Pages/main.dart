import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/Auth_Wraper.dart';
import 'package:mazadatkom/Pages/Sign_in_Page.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthWrapper(),);
  }
}
