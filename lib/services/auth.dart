import 'package:firebase_auth/firebase_auth.dart';
import 'package:poolish/models/user.dart';
import 'package:poolish/services/database.dart';
import 'package:poolish/shared/constants.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj baseed on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null? User(uid: user.uid) : null;
  }

  Stream <User>get user{
    // return _auth.onAuthStateChanged.map((FirebaseUser user)=> _userFromFirebaseUser(user));
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign ni anon
  Future signInAnon()async {
    try {
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      
    } catch(e){
      print(e.toString());
      return null;
    }

  }



  //sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(user.uid);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);      
      FirebaseUser user = result.user;
      //create a new document with the uid
      await DatabaseService(uid: user.uid).updateUserData(List<String>.filled(testNames.length, null));
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}