import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';
import 'package:mazadatkom/Pages/SearchWidget.dart';
import 'package:mazadatkom/Pages/SignUpPage.dart';

import '../DBs/User_Model.dart';

class SignInMain extends StatefulWidget {
  const SignInMain({Key? key}) : super(key: key);

  @override
  State<SignInMain> createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String checkNotify = '';

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
        padding: EdgeInsets.only(
            left: 50,
            right: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
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
                  obscureText: true,
                ),
                Text(
                  checkNotify,
                  style: const TextStyle(color: Colors.redAccent),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String pass = passController.text;

                    bool signInCheck = await DataBaseHelper.instance
                        .validateSignIn(name, pass);

                    if (!signInCheck) {
                      setState(() {
                        checkNotify = "username or password don't exist";
                      });
                      return;
                    }

                    setState(() {
                      checkNotify = '';
                    });

                    User user = await DataBaseHelper.instance.getUser(name);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchWidget(user: user),
                      ),
                    );
                  },
                  child: const Text('Sign In'),
                ),
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
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
