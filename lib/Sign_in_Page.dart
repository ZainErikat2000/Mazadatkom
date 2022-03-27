import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        color: Colors.red,
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
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    child: Image.asset(
                      'assets/images/google-logo.png',
                      width: 24,
                      height: 24,
                    ),
                    opacity: 1.0,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Opacity(
                    child: Image.asset(
                      'assets/images/google-logo.png',
                      width: 24,
                      height: 24,
                    ),
                    opacity: 0.0,
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white, shadowColor: Colors.grey[300]),
            ),
            const SizedBox(
              height: 8,
            ),
            //sign in with facebook
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Opacity(
                    child: Image.asset(
                      'assets/images/facebook-logo.png',
                      width: 24,
                      height: 24,
                    ),
                    opacity: 1.0,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'Sign in with Facebook',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Opacity(
                    child: Image.asset(
                      'assets/images/facebook-logo.png',
                      width: 24,
                      height: 24,
                    ),
                    opacity: 0.0,
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue, shadowColor: Colors.grey[300]),
            ),
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
