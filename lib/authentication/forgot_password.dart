import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController enteryourEmailController =
      TextEditingController();

  @override
  void dispose() {
    enteryourEmailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: enteryourEmailController.text.trim());
          showDialog(
            
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green[50],
              content: Text(
                "The link has been sent! Kindly check your email.",
            style:TextStyle(
              fontSize: 19,
              color: Colors.green
            )));
          });
    } on FirebaseAuthException catch (e) {
    
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red[50],
              content: Text("Invalid Email",
            style:TextStyle(
              fontSize: 19,
              color: Colors.red
            )));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          centerTitle: true,
          title: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/coins.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.linearToSrgbGamma()),
          ),
          child: Padding(
            padding: (EdgeInsets.all(25.0)),
            child: Column(children: [
              Text(
                "Don't worry, we got you!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "You will receive a link after entering your email.",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              TextField(
                controller: enteryourEmailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  prefixIcon: Icon(Icons.email),
                  labelText: ("Enter your Email"),
                ),
              ),
              SizedBox(height: 40),
              MaterialButton(
                onPressed: passwordReset,
                child: Text("Reset Password"),
                color: Colors.teal[300],
              )
            ]),
          ),
        ));
  }
}
