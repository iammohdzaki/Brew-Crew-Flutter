import 'package:brew_crew/services/Auth.dart';
import 'package:brew_crew/shared/Constants.dart';
import 'package:brew_crew/shared/Loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  // text field state
  final _formKey=GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMsg='';
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                 /* labelStyle: Theme.of(context).textTheme.display1.copyWith(
                      fontSize: 20.0
                  ),
                  labelText: 'Email'*/
                ),
                validator: (val) => val.isEmpty ? 'Enter Email Address':null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Password',
                 /* labelStyle: Theme.of(context).textTheme.display1.copyWith(
                      fontSize: 20.0
                  ),
                  labelText: 'Password'*/
                ),
                validator: (val) => val.length < 6 ? 'Enter Password more than 6 chars long':null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                       dynamic result=await _auth.signInUser(email, password);
                       if(result == null){
                         setState(() {
                            errorMsg='Please supply valid creds';
                            loading=false;
                         });
                       }
                      print(email);
                      print(password);
                    }
                  }
              ),
              SizedBox(height: 20.0),
              Text(
                errorMsg,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}