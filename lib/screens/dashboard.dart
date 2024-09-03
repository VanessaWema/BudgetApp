import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stubudget/authentication/log_in.dart';

import 'package:stubudget/screens/dashboard/blocs/get_expense_bloc/get_expense_bloc.dart';
import 'package:stubudget/screens/home.dart';
import 'package:stubudget/screens/settings.dart';
import 'package:stubudget/screens/settings/blocs/bloc/create_expense_bloc.dart';
import 'package:stubudget/screens/settings/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:stubudget/screens/settings/blocs/get_categories_bloc/get_categories_bloc.dart';

class Dashboard extends StatefulWidget {
  final List<Expense> expenses;

  const Dashboard(this.expenses, {super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpenseBloc, GetExpenseState>(
      builder: (context, state) {
        if (state is GetExpenseSuccess) {
          final expenses = state.expenses;
          return Scaffold(
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
                  "Dashboard",
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
                  ListTile(
                    leading: (Icon(Icons.dashboard, size: 30)),
                    title: Text("DASHBOARD"),
                    onTap: () {
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
                    onTap: () async {
                      Expense? newExpense = await Navigator.push(
                        context,
                        MaterialPageRoute<Expense>(
                          builder: (BuildContext context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    CreateCategoryBloc(FirebaseExpenseRepo()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    GetCategoriesBloc(FirebaseExpenseRepo())
                                      ..add(GetCategories()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CreateExpenseBloc(FirebaseExpenseRepo()),
                              ),
                            ],
                            child: Settings(),
                          ),
                        ),
                      );
                      if (newExpense != null) {
                  setState(() {
                    state.expenses.insert(0,newExpense);
                  });
                }
                      
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal[700],
              onPressed: () async {
                Expense? newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                        builder: (BuildContext context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      CreateCategoryBloc(FirebaseExpenseRepo()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      GetCategoriesBloc(FirebaseExpenseRepo())
                                        ..add(GetCategories()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      CreateExpenseBloc(FirebaseExpenseRepo()),
                                ),
                              ],
                              child: Settings(),
                            )));
                if (newExpense != null) {
                  setState(() {
                    state.expenses.insert(0, newExpense);
                  });
                }
              },
              child: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: Column(children: [
                        Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Balance"),
                              Text(
                                "sh 20000",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.arrow_downward,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Income",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            Text("sh 80000"),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.arrow_downward,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Expenses",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text("sh 60000"),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Column(children: [
                          Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                        ]),
                        SizedBox(height: 20),
                        Container(
                          height: 700,
                          child: ListView.builder(
                              itemCount: expenses.length,
                              itemBuilder: (context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 5),
                                              color: Colors.teal,
                                              spreadRadius: 2,
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            expenses[i].category.name,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  expenses[i].category.color),
                                            ),
                                          ),
                                          SizedBox(width: 40),
                                          Row(
                                            children: [
                                              Text(
                                                '\$${expenses[i].amount}.00',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy')
                                                .format(expenses[i].date),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ])),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
