import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> searchBarcodeId(
      {required String query}) async {
    final result = await _firebaseFirestore
        .collection('nutritional_information')
        .where('barcodeId', isEqualTo: query)
        .get();
    if (result.docs.isNotEmpty) {
      return result.docs[0];
    } else {
      return null;
    }
  }

  Future<void> addData(
      {required String barcodeId,
      required String? thumbnail,
      required String name,
      required String carb,
      required String protein,
      required String fat}) async {
    await _firebaseFirestore.collection('nutritional_information').add({
      'barcodeId': barcodeId,
      'thumbnail': thumbnail,
      'name': name,
      'carb': carb,
      'protein': protein,
      'fat': fat,
    });
  }
}
