import 'package:flutter/material.dart';
import 'package:mazadatkom/Custom_Widgets/SocialSignInButton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          'Welcome to Mazadatkom',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(60),
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const Text(
              'Sign in with...',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 32,
            ),
            //google sign in button
            SocialSignInButton(
              onPressed: () {},
              imageAsset: 'assets/images/google-logo.png',
              buttonText: 'Sign in with Google',
              buttonColor: Colors.white,
              shadowColor: Colors.grey[300],
              textColor: Colors.blue,
              imageOpacity: 1.0,
            ),
            const SizedBox(
              height: 8,
            ),
            //sign in with facebook
            SocialSignInButton(
              onPressed: () {},
              imageAsset: 'assets/images/facebook-logo.png',
              buttonText: 'Sign in with Facebook',
              buttonColor: Colors.blue,
              shadowColor: Colors.grey[300],
              textColor: Colors.white,
              imageOpacity: 1.0,
            ),
            const SizedBox(
              height: 8,
            ),
            SocialSignInButton(
              onPressed: () {},
              imageAsset: 'assets/images/facebook-logo.png',
              buttonText: 'Sign in with Email',
              buttonColor: Colors.lime,
              shadowColor: Colors.black,
              textColor: Colors.black,
              imageOpacity: 0.0,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
