// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:stubudget/authentication/log_in.dart';
import 'package:stubudget/screens/dashboard.dart';

import 'package:stubudget/screens/profile.dart';


import 'package:stubudget/screens/settings.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          title: const Text(
            "StuBudget",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.teal[200],
          actions: [
            Text(
              "Home",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal[50],
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(Icons.money_off_csred_sharp, size: 60),
              ),
              ListTile(
                  leading: (Icon(
                    Icons.home,
                    size: 30,
                  )),
                  title: Text("HOME"),
                  onTap: () {
                    Navigator.pushNamed(context, '/Home');
                  }),
              ListTile(
                leading: (Icon(Icons.dashboard, size: 30)),
                title: Text("DASHBOARD"),
                onTap: () {
                 final List<Expense> expenses = [
                  
                  ];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(expenses),
                    ),
                  );
                },
                //go to dashboard
              ),
              ListTile(
                leading: (Icon(Icons.settings, size: 30)),
                title: Text("SETTINGS"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  );
                },
              ),
              SizedBox(height: 60),
              ListTile(
                trailing: (Icon(Icons.logout_rounded, size: 30)),
                title: Text("Log Out",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogIn(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome to StuBudget!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),

                    //notification
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[200],
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.money_off_csred_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text("Take control of your finances with ease."),
                SizedBox(height: 30),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 200,
                    width: 400,
                    child: Column(
                      children: [
                        Title(
                          color: Colors.black,
                          child: Text(
                            "About Us",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.teal[100],
                        ),
                        Text(
                          "StuBudget is designed to help students manage their money, track expenses and plan budgets effortlessly. Start your journey towards financial independence today. Let's make every cent count!",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.teal[200],
                  child: Center(
                      child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.teal,
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ]),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 30,
                          ),
                          title: Text("My Profile"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ));
                          },
                        ),
                      ),
                     
                    ],
                  )),
                )
              ]),
            ),
          ),
        )));
  }
}
