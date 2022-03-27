import 'package:flutter/material.dart';
import 'package:mazadatkom/Custom%20Widgets/SocialSignInButton.dart';

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
                textColor: Colors.blue,),
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
          textColor: Colors.white,),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black54),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
