import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/utils/show_snackbar.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';

class FirebaseAuthMethods {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuthMethods(this._auth);

  // GET USER DATA
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // EMAIL SIGN IN
  Future<void> signInWithEmailPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message.toString());
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'An unexpected error occurred: ${e.toString()}');
      }
    }
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data();
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.message!);
      }
    }
  }

  //Add Entry
  Future<bool> addNewEntryToDb(EntryModel model) async {
    try {
      await _firestore.collection('entries').doc(model.sId).set(model.toJson());
      return true;
    } on FirebaseException catch (e) {
      print('Error adding entry: $e');
      return false;
    }
  }

  Future<bool> editEntryInDb(
      String docId, String entryId, List<DetailsModel> updatedItems) async {
    try {
      await _firestore.collection('entries').doc(docId).update(
          {'itemDetails': updatedItems.map((item) => item.toJson()).toList()});
      return true;
    } on FirebaseException catch (e) {
      print('Error updating entry: $e');
      rethrow;
    }
  }

  Future<void> updateDarkModeTheme(user, bool isDarkMode) async {
    try {
      await _firestore
          .collection('isDarkTheme')
          .doc(user.email)
          .set({'isDarkMode': isDarkMode}, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print('Error updating entry: $e');
      rethrow;
    }
  }

  Future<bool?> getCurrentUserDarkModePreference(String userEmail) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('isDarkTheme').doc(userEmail).get();

      if (snapshot.exists) {
        dynamic isDarkModeValue = snapshot.data()?['isDarkMode'];
        if (isDarkModeValue is bool) {
          return isDarkModeValue;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error getting dark mode preference: $e');
      return false;
    }
  }

  Future<List<EntryModel>> getEntries() async {
    try {
      final entryRef = _firestore
          .collection('entries')
          .withConverter<EntryModel>(
              fromFirestore: (snapshot, _) =>
                  EntryModel.fromJson(snapshot.data()!),
              toFirestore: (entries, _) => entries.toJson());
      QuerySnapshot<EntryModel> entryDoc;

      entryDoc = await entryRef.get();

      return entryDoc.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e, stacktrace) {
      print('Error while loading $stacktrace : ${e.code}');
    }
    return [];
  }

  //DELETE function
  Future<bool> deleteEntry(String documentId) async {
    try {
      await _firestore.collection('entries').doc(documentId).delete();
      print('$documentId successfully deleted.');
      return true;
    } catch (error) {
      print('Error deleting document: $error');
      rethrow;
    }
  }

  Future<bool> deleteItemFromEntry(String documentId, String entryId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('entries').doc(documentId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<dynamic> itemDetails = data['itemDetails'] ?? [];

        itemDetails.removeWhere((item) => item['_id'] == entryId);

        await _firestore
            .collection('entries')
            .doc(documentId)
            .update({'itemDetails': itemDetails});
        print('Item $entryId successfully deleted from $documentId.');
        return true;
      } else {
        print('Document $documentId does not exist.');
        return false;
      }
    } catch (error) {
      print('Error deleting item from document: $error');
      rethrow;
    }
  }
}
