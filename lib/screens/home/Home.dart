import 'package:brew_crew/models/Brew.dart';
import 'package:brew_crew/screens/home/BrewList.dart';
import 'package:brew_crew/screens/home/SettingsForm.dart';
import 'package:brew_crew/services/Auth.dart';
import 'package:brew_crew/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Log Out'),
                onPressed: () async {
                  await _authService.signOut();
                },
            ),
            FlatButton.icon(
                onPressed: () async {
                  _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('Settings')
            )
          ],
        ),
        body: BrewList()
      ),
    );
  }
}
