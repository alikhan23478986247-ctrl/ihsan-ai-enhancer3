import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart';
import '../models/history_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveHistory(HistoryModel history) async {
    await _db
        .collection(AppConstants.usersCollection)
        .doc(history.userId)
        .collection(AppConstants.historyCollection)
        .doc(history.id)
        .set(history.toMap());
  }

  Stream<List<HistoryModel>> getHistory(String userId) {
    return _db
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .collection(AppConstants.historyCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HistoryModel.fromMap(doc.data()))
            .toList());
  }

  Future<void> deleteHistory(String userId, String historyId) async {
    await _db
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .collection(AppConstants.historyCollection)
        .doc(historyId)
        .delete();
  }
}
