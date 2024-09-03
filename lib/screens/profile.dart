import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stubudget/authentication/log_in.dart';

import 'package:stubudget/screens/home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController changeUsernameController =
      TextEditingController();
  final TextEditingController changeEmailController = TextEditingController();

  final String userId = "your_user_id_here";

  void _changeUsername() async {
    final newUsername = changeUsernameController.text.trim();
    if (newUsername.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'username': newUsername,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username has been updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error')));
      }
    }
  }

  void _changeEmail() async {
    final newEmail = changeEmailController.text.trim();
    if (newEmail.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'email': newEmail,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email has been updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text(
          "StuBudget",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.teal[200],
        actions: const [
          Text(
            "Profile",
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
                "The information you enter here will not be visible to other users."),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/jakey ⋆.jpg'),
            ),
            Text(
              "Profile picture",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: null,
                  builder: (context, snapshot) {
                    return ListTile(
                      title: Text("Username"),
                      subtitle: Text("Vanessa"),
                      leading: Icon(CupertinoIcons.person),
                      trailing: IconButton(
                          icon: Icon(CupertinoIcons.square_pencil),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: TextField(
                                        controller: changeUsernameController,
                                        decoration: InputDecoration(
                                            labelText: "Change your username")),
                                    backgroundColor: Colors.teal[50],
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            _changeUsername();

                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.teal),
                                          ))
                                    ],
                                  );
                                });
                          }),
                    );
                  }),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text("Email"),
                subtitle: Text("vanessamuyiemba@gmail.com"),
                leading: Icon(CupertinoIcons.mail),
                trailing: IconButton(
                    icon: Icon(CupertinoIcons.square_pencil),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: TextField(
                                controller: changeEmailController,
                                decoration: InputDecoration(
                                    labelText: "Change your email"),
                              ),
                              backgroundColor: Colors.teal[50],
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _changeEmail();

                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.teal),
                                    ))
                              ],
                            );
                          });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
