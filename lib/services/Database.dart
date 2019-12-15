import 'package:brew_crew/models/Brew.dart';
import 'package:brew_crew/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection=Firestore.instance.collection('brew');

  /// Update User Brew Data
  Future updateUserData(String sugars,String name,int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  ///Get User Brew
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewFromSnapshot);
  }

  ///Get User Doc Stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  ///User Data from SnapShot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      strength: snapshot.data['strength'],
      sugars: snapshot.data['sugars'],
    );
  }

  ///Get Brew List
  List<Brew> _brewFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }
}