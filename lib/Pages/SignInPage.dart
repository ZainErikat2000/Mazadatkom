import 'package:flutter/material.dart';
import 'package:mazadatkom/Pages/SignUpPage.dart';

class SignInMain extends StatefulWidget {
  const SignInMain({Key? key}) : super(key: key);

  @override
  State<SignInMain> createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Welcome to Mazadatkom',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'User Name', icon: Icon(Icons.person)),
              ),
              TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                    hintText: 'Password', icon: Icon(Icons.key)),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Sign In')),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
