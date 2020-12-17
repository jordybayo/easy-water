import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatastoreRepository {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference nfcTags =
      FirebaseFirestore.instance.collection('card_tags');

  //adding documents

  Future<void> addUser(
      {@required id,
      @required name,
      @required phoneNumber,
      @required waterFlow,
      @required email}) async {
    print('***********************th id is $id');
    // Call the user's CollectionReference to add a new user
    return users
        .doc('$id')
        .set({
          'id': id, // CSdgfhgsrgGFWF142
          'name': name, // john Doe
          'phone_number': phoneNumber, // 6xx xxx xxx
          'water_flow': waterFlow, // 42
          'history': [],
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNfcTag({@required id}) async {
    // Call the user's CollectionReference to add a new user
    return nfcTags
        .doc('$id')
        .set({
          'id': id, // CSdgfhgsrgGFWF142
          'water_flow': 0,
          'history': []
        })
        .then((value) => print("NfcTag Added"))
        .catchError((error) => print("Failed to add NfcTag: $error"));
  }

  // one time read documents

  Future<DocumentSnapshot> getUserDetailsDoc({@required documentId}) async {
    return await users.doc(documentId).get();
  }

  Future<DocumentSnapshot> getNfcTagDetailDoc({@required documentId}) async {
    return await nfcTags.doc(documentId).get();
  }

  // change water flow value

  Future<void> updateUserWaterFlow(
      {@required documentId, @required double newFlow}) {
    return users
        .doc('$documentId')
        .update({'water_flow': newFlow})
        .then((value) => print("User water flow Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateNfcTagWaterFlow(
      {@required documentId, @required double newFlow}) {
    return nfcTags
        .doc('$documentId')
        .update({'water_flow': newFlow})
        .then((value) => print("NfcTag water flow Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // log water flow changement

  Future<void> logHistoryUserWaterFlow(
      {@required documentId, @required List newHistory}) {
    return users
        .doc('$documentId')
        .update({'history': newHistory})
        .then((value) => print("User history water flow Updated"))
        .catchError((error) =>
            print("Failed to update user water flow history: $error"));
  }

  Future<void> logHistoryNfcTagWaterFlow(
      {@required documentId, @required List newHistory}) {
    return nfcTags
        .doc('$documentId')
        .update({'history': newHistory})
        .then((value) => print("NfcTag history water flow Updated"))
        .catchError((error) =>
            print("Failed to update user water flow history: $error"));
  }
}
