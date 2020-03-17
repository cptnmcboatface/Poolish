import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poolish/shared/constants.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference testCollection =
      Firestore.instance.collection('tests');

  final Firestore _firestore = Firestore.instance;

  // collection reference

  Future updateUserData(List<String> data) async {
    return await testCollection
        .document(uid)
        .setData(new Map.fromIterables(testNames, data));
  }

  Future<void> updateDocument(String testName, String selected) async {
    return _firestore.collection('tests').document(uid).updateData({
      testName: selected,
    });
  }

  Stream<DocumentSnapshot> get testList {
    return _firestore.collection('tests').document(uid).snapshots();
  }
}
