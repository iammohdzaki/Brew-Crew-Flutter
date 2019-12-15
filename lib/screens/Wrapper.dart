import 'package:brew_crew/models/User.dart';
import 'package:brew_crew/screens/authentication/Authenticate.dart';
import 'package:brew_crew/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return user != null ? Home() : Authenticate() ;
  }
}
