import 'package:flutter/material.dart';
import 'package:mazadatkom/DBs/DataBaseHelper.dart';

import '../DBs/User_Model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //name and email controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //password check controllers
  TextEditingController passController = TextEditingController();
  TextEditingController passRepeatController = TextEditingController();

  String credNotify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
            left: 50,
            right: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  icon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  icon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                    hintText: 'Password', icon: Icon(Icons.key)),
              ),
              TextFormField(
                controller: passRepeatController,
                decoration: const InputDecoration(
                    hintText: 'Repeat Password', icon: Icon(Icons.key)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                credNotify,
                style: TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(
                height: 16,
              ),
              //sign up functionality
              ElevatedButton(
                onPressed: () async {
                  String pass = passController.text;
                  String passRe = passRepeatController.text;

                  String name = nameController.text;
                  String email = emailController.text;

                  //all fields check
                  if (name == '' || email == '' || pass == '' || passRe == '') {
                    setState(() {
                      credNotify = "must fill all fields";
                    });
                    return;
                  }

                  //name and email check
                  if (name.contains(" ") || email.contains(" ")) {
                    setState(() {
                      credNotify =
                          "user name and email mustn't contain whitespace";
                    });
                    return;
                  }

                  //desired password match check
                  if (passRe != pass) {
                    setState(() {
                      credNotify = "password doesn't match";
                    });
                    return;
                  }

                  setState(() {
                    credNotify = '';
                  });
                  //add user to database
                  var valSignUp = await DataBaseHelper.instance.validateSignUp(name, email);

                  if(valSignUp == false)
                    {
                      setState(() {
                        credNotify = 'user name or email already exists';
                      });

                      return;
                    }

                  int numUsers =
                      await DataBaseHelper.instance.getUsersCount() ?? 0;

                  User user = User(
                      id: numUsers + 1, name: name, email: email, password: pass);

                  await DataBaseHelper.instance.insertUser(user);
                  await DataBaseHelper.instance.printUsers();
                },
                child: const Text('Sign Up'),
              ),
              ElevatedButton(onPressed: () async {await DataBaseHelper.instance.printUsers();}, child: Text('hello'),)
            ],
          ),
        ),
      ),
    );
  }
}
