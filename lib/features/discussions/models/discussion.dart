import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'comments.dart'; // Import the CommentModel

class DiscussionModel {
  final String title;
  final String description;
  final String email; // New email variable
  int noOfLikes;
  int noOfComments;
  final DateTime timestamp;
  final String discussionId;

  DiscussionModel({
    required this.title,
    required this.description,
    required this.email, // Include email in the constructor
    this.noOfLikes = 0,
    this.noOfComments = 0,
    required this.timestamp,
    String? discussionId, // Optional so it can auto-generate
  }) : discussionId = discussionId ?? const Uuid().v4(); // Auto-generate ID if not provided

  // Convert model to a Map for Firebase or other database storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'email': email, // Add email to the map
      'noOfLikes': noOfLikes,
      'noOfComments': noOfComments,
      'timestamp': Timestamp.fromDate(timestamp), // Store as Firestore Timestamp
      'discussionId': discussionId,
    };
  }

  // Create DiscussionModel from Firebase or other database document
  factory DiscussionModel.fromMap(Map<String, dynamic> map) {
    return DiscussionModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      email: map['email'] ?? '', // Initialize email from map
      noOfLikes: map['noOfLikes'] ?? 0,
      noOfComments: map['noOfComments'] ?? 0,
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
      discussionId: map['discussionId'] ?? const Uuid().v4(),
    );
  }

  // Method to like the discussion
  void likeDiscussion() {
    noOfLikes++;
  }

  // Method to add a comment
  void addComment() {
    noOfComments++;
  }

  // Method to remove a comment
  void removeComment() {
    if (noOfComments > 0) {
      noOfComments--;
    }
  }

  // Method to add a new discussion by providing title, description, and email
  static DiscussionModel createDiscussion({
    required String title,
    required String description,
    required String email, // Include email parameter
  }) {
    return DiscussionModel(
      title: title,
      description: description,
      email: email, // Set email
      timestamp: DateTime.now(), // Set the current timestamp
    );
  }

  // Method to add a comment to the discussion
  Future<void> addCommentToDiscussion(String discussionId, String content) async {
    final comment = CommentModel(
      content: content,
      timestamp: DateTime.now(), // Set the current timestamp for the comment
    );

    try {
      // Create the comment in the specific discussion's sub-collection
      await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussionId)
          .collection('comments')
          .doc(comment.commentId) // Using commentId as document ID
          .set(comment.toMap());

      // Optionally update the discussion to increment the comment count
      await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussionId)
          .update({'noOfComments': FieldValue.increment(1)});
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  // Method to fetch discussions in descending order by timestamp
  static Future<List<DiscussionModel>> fetchDiscussions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('discussions')
          .orderBy('timestamp', descending: true) // Order by timestamp in descending order
          .get();

      // Convert QuerySnapshot to List<DiscussionModel>
      return querySnapshot.docs.map((doc) {
        return DiscussionModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching discussions: $e');
      return []; // Return an empty list on error
    }
  }
}
