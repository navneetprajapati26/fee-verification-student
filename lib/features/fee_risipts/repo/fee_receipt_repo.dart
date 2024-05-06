import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fee_verification_student/features/fee_risipts/model/fee_receipt_model.dart';

class FeeReceiptRepository {
  final CollectionReference _feeReceiptsCollection =
  FirebaseFirestore.instance.collection('feeReceipts');

  Future<FeeReceiptModel> addFeeReceipt(FeeReceiptModel feeReceiptModel) async {
    // Generate a new unique ID for the document
    final newDocumentId = _feeReceiptsCollection.doc().id;

    // Update the feeReceiptModel with the new ID
    final updatedFeeReceiptModel =
    feeReceiptModel.copyWith(id: newDocumentId);

    // Add the document to Firestore
    await _feeReceiptsCollection.doc(newDocumentId).set(updatedFeeReceiptModel.toMap());

    // Return the updatedFeeReceiptModel
    return updatedFeeReceiptModel;
  }
  Future<void> updateFeeReceipt(FeeReceiptModel feeReceiptModel) async {
    if (feeReceiptModel.id == null) {
      throw Exception('Fee receipt ID is null');
    }

    // Update the document in Firestore
    await _feeReceiptsCollection
        .doc(feeReceiptModel.id)
        .update(feeReceiptModel.toMap());
  }

  Future<void> deleteFeeReceipt(String feeReceiptId) async {
    // Delete the document from Firestore
    await _feeReceiptsCollection.doc(feeReceiptId).delete();
  }

  Future<FeeReceiptModel?> getFeeReceiptById(String feeReceiptId) async {
    // Get the document from Firestore
    final documentSnapshot =
    await _feeReceiptsCollection.doc(feeReceiptId).get();

    // If the document exists, return the FeeReceiptModel object
    if (documentSnapshot.exists) {
      return FeeReceiptModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }

    // Return null if the document doesn't exist
    return null;
  }

  Future<List<FeeReceiptModel>> getFeeReceiptsByIds(
      {required List<String> feeReceiptIds}) async {
    List<FeeReceiptModel> feeReceipts = [];

    for (String id in feeReceiptIds) {
      FeeReceiptModel? feeReceipt = await getFeeReceiptById(id);
      if (feeReceipt != null) {
        feeReceipts.add(feeReceipt);
      }
    }

    return feeReceipts;
  }

  Stream<List<FeeReceiptModel>> getAllFeeReceipts() {
    // Get a stream of all documents in the 'feeReceipts' collection
    return _feeReceiptsCollection.snapshots().map((querySnapshot) {
      // Map each document to a FeeReceiptModel object and return a list
      return querySnapshot.docs
          .map((doc) => FeeReceiptModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}