import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/SignInPage.dart';
import 'package:mazadatkom/Pages/Sign_in_Page(not used).dart';

import '../DBs/User_Model.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

User? user;

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    if (user == null){
      return const SignInMain();}
    else {
      return const Scaffold(
        body: Center(
          child: Text('logged in'),
        ),
      );
    }
  }
}
