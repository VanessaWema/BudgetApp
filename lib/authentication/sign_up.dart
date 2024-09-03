// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stubudget/screens/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController createUsernameController =
      TextEditingController();
  final TextEditingController yourEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureTextforConfirmPass = true;

  Future<void> SignUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Passwords don't match!"),
        backgroundColor: Colors.red,
      ));
      return; 
    }

    try {
      // If all goes well
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: yourEmailController.text.trim(),
              password: passwordController.text.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': yourEmailController.text.trim(),
        'username': createUsernameController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration Successful!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } on FirebaseException catch (e) {
       
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error!: ${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: ConstrainedBox(constraints: BoxConstraints(),
        child : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/coins.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.linearToSrgbGamma(),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                //icon
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.money_off_csred_sharp,
                    size: 70,
                  ),
                ),

                SizedBox(height: 10),

                //title
                Text(
                  "StuBudget",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Sign Up",
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
                  controller: createUsernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    prefixIcon: Icon(Icons.people_alt),
                    labelText: ("Create username"),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: yourEmailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    prefixIcon: Icon(Icons.email),
                    labelText: ("Your Email"),
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
                      prefixIcon: Icon(Icons.password_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: ("Password")),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscureTextforConfirmPass,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    prefixIcon: Icon(Icons.password_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureTextforConfirmPass
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureTextforConfirmPass =
                              !_obscureTextforConfirmPass;
                        });
                      },
                    ),
                    labelText: ("Confirm Password"),
                  ),
                ),

                SizedBox(height: 40),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.teal[300]),
                    ),
                    onPressed: SignUp,
                      
                    child: const Text("SIGN UP")),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Already have an account?"),
                  ],
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/LogIn');
                  },
                  child: new Text(
                    "Log in",
                    style: TextStyle(color: Colors.teal[600],
                    fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )
            ),
        ),
        ),

      ),
    );
  }
}
