import 'package:expense_repository/expense_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stubudget/authentication/forgot_password.dart';
import 'package:stubudget/authentication/log_in.dart';
import 'package:stubudget/authentication/sign_up.dart';

import 'package:stubudget/screens/dashboard/blocs/get_expense_bloc/get_expense_bloc.dart';

import 'package:stubudget/screens/home.dart';
import 'package:stubudget/screens/profile.dart';

import 'package:stubudget/screens/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stubudget/simple_bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<GetExpenseBloc>(
      create: (context) =>
          GetExpenseBloc(FirebaseExpenseRepo())..add(GetExpenses()),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: (false),
      home: Home(),
      routes: {
        '/LogIn': (context) => LogIn(),
        '/SignUp': (context) => SignUp(),
        '/Home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/settings': (context) => Settings(),
        '/ForgotPassword': (context) => ForgotPassword(),
      },
    );
  }
}
