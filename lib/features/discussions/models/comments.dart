import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CommentModel {
  final String content;
  final DateTime timestamp;
  final String commentId;

  CommentModel({
    required this.content,
    required this.timestamp,
    String? commentId,
  }) : commentId = commentId ?? const Uuid().v4(); // Auto-generate ID if not provided

  // Convert comment model to a Map for Firebase or other database storage
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp), // Store as Firestore Timestamp
      'commentId': commentId,
    };
  }

  // Create CommentModel from Firebase or other database document
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
      commentId: map['commentId'] ?? const Uuid().v4(),
    );
  }
}
