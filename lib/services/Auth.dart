import 'package:brew_crew/models/User.dart';
import 'package:brew_crew/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Convert Firebase User to User Object
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Sign In Anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//Sign In with Email & Password
  Future signInUser(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(error){
      print(error.toString());
      return null;
    }
  }

//Register with  Email & Password
  Future registerWithEmailPassword(String email,String password) async {
    try{
      AuthResult result=await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      //Create Dummy Data for User
      await DatabaseService(uid: user.uid).updateUserData('0', 'New Member', 100);
      return _userFromFirebaseUser(user);
    }catch(error){
      print(error.toString());
      return null;
    }
  }

//Sign Out
Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
}

}
