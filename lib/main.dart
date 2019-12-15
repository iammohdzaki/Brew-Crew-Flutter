import 'package:brew_crew/screens/Wrapper.dart';
import 'package:brew_crew/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
          fontFamily: 'Raleway',
        ),
      ),
    );
  }
}