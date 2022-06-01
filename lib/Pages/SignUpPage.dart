import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passRepeatController = TextEditingController();
  String passNotify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(
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
            SizedBox(height: 16,),
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
            const SizedBox(height: 8,),
            Text(passNotify,style: TextStyle(color: Colors.redAccent),),
            const SizedBox(height: 8,),
              //sign up functionality
              ElevatedButton(onPressed: () {
                if(passRepeatController.text != passController.text)
                {
                  setState(() {
                    passNotify = "password doesn't match";
                  });
                  return;
                }

              setState(() {
                  passNotify = '';
                });
                //add user to database
              },
                  child: Text('Sign Up'),),
            ],
          ),
        ),
      ),
    );
  }
}
