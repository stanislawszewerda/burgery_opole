import 'package:burgery_opole/App/cubit/root_cubit.dart';
import 'package:burgery_opole/App/features/Home/home_page.dart';
import 'package:burgery_opole/App/features/Login/login_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'firebase_options.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RootCubit()..start(),
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            final user = state.user;
            if (user == null) {
              return LoginPage();
            }
            return HomePage(user: user);
          },
        ));
  }
}
