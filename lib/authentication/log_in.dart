// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stubudget/screens/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login success!"), backgroundColor: Colors.green));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("account is non-existent!"),
            backgroundColor: Colors.red));
      } else if (e.code == 'wrong password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("inaccurate password"), backgroundColor: Colors.red));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${e.message ?? 'An unknown error occurred'}'),
            backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[30],
      body: SingleChildScrollView(
        child:ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/coins.jpg',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma()),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              //icon
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.money_off_csred_sharp, size: 70),
              ),

              //title
              Text(
                "StuBudget",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  labelText: ("Email"),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  labelText: ("Password"),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.teal[300]),
                      ),
                      child: const Text("LOG IN"),
                      onPressed: login),
                  SizedBox(width: 120),
                  new GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/ForgotPassword');
                    },
                    child: new Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Colors.teal[700], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text("Don't have an account?"),
                ],
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/SignUp');
                },
                child: new Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.teal[600], fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
      ),
    );
  }
}
