import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/SignInPage.dart';
import 'package:mazadatkom/Pages/Sign_in_Page(not used).dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return const SignInMain();
  }
}
