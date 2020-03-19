import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poolish/shared/constants.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference testCollection = Firestore.instance.collection('tests');
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final Firestore _firestore = Firestore.instance;

  // collection reference

  Future updateUserData(List<String> data, String email) async {
    usersCollection.document(uid).setData({"name" : "",
                                          "designation" : "",
                                          "email" : email,
                                          "address" : "N/A"});
    var myMap=new Map.fromIterables(testNames, data);
    print({DateTime.now().toString():{"testVal":myMap,"completed":false}});
    return await testCollection
        .document(uid)
        .setData({DateTime.now().toString():{"testVal":myMap,"completed":false}});
  }

  Future<void> updateDocument(String testName, String selected) async {
    return _firestore.collection('tests').document(uid).updateData({
      testName: selected,
    });
  }
  Future<void> updateUserDataDocument(var name, var des, var add) async {
    return _firestore.collection('users').document(uid).updateData({
      "name":name,
      "designation":des,
      "address":add,
    });
  }

  Stream<DocumentSnapshot> get testList {
    return _firestore.collection('tests').document(uid).snapshots();
  }
  Stream<DocumentSnapshot> get userDataStream {
    return _firestore.collection('users').document(uid).snapshots();
  }
}
