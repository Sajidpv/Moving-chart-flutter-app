import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haash_moving_chart/features/chart/data/model/entry_model.dart';

class FirebaseAuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      print(updatedItems.first.remark);
      await _firestore.collection('entries').doc(docId).update(
          {'itemDetails': updatedItems.map((item) => item.toJson()).toList()});
      return true;
    } on FirebaseException catch (e) {
      print('Error updating entry: $e');
      rethrow;
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
