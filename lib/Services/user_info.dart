import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getNameFromFirestore() async {
    final documentId = await getFirestoreDocumentIdForCurrentUser('Lawyer');
    if (documentId != null) {
      final name = await _getNameFromCollection('Lawyer', documentId);
      if (name != null) {
        return name;
      }
    }

    final clientDocumentId =
        await getFirestoreDocumentIdForCurrentUser('Client');
    if (clientDocumentId != null) {
      final name = await _getNameFromCollection('Client', clientDocumentId);
      if (name != null) {
        return name;
      }
    }

    return "No document found"; // Return this if no document is found in both collections
  }

  Future<String?> getFirestoreDocumentIdForCurrentUser(
      String collectionName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('email', isEqualTo: user.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0].id;
      }
    }
    return null;
  }

  Future<String?> _getNameFromCollection(
      String collectionName, String documentId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .get();

    if (userDoc.exists) {
      return userDoc.data()?['name'];
    } else {
      return null;
    }
  }
}
