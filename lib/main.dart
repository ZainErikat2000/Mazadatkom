import 'package:flutter/material.dart';
import 'package:mazadatkom/Sign_in_Page.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SignInPage(),);
  }
}
