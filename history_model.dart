import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String id;
  final String userId;
  final String originalImageUrl;
  final String processedImageUrl;
  final String featureType;
  final DateTime timestamp;

  HistoryModel({
    required this.id,
    required this.userId,
    required this.originalImageUrl,
    required this.processedImageUrl,
    required this.featureType,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'originalImageUrl': originalImageUrl,
      'processedImageUrl': processedImageUrl,
      'featureType': featureType,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      originalImageUrl: map['originalImageUrl'] ?? '',
      processedImageUrl: map['processedImageUrl'] ?? '',
      featureType: map['featureType'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
