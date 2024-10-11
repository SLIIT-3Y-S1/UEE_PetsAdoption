import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawpal/features/discussions/models/discussion.dart'; // Update with the correct import
import 'package:pawpal/features/discussions/models/comments.dart'; // Update with the correct import // Import your CommentModel

class FirestoreService {
  // Add new discussion
  Future<void> addDiscussionToFirestore(DiscussionModel discussion) async {
    try {
      await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussion.discussionId) // Use discussionId as document ID
          .set(discussion.toMap());
      print('Discussion added successfully');
    } catch (e) {
      print('Error adding discussion: $e');
    }
  }

  // Retrieve all discussions in descending order of the timestamp
  Future<List<DiscussionModel>> getAllDiscussions() async {
    try {
      // Query discussions collection and order by timestamp in descending order
      final QuerySnapshot discussionsSnapshot = await FirebaseFirestore.instance
          .collection('discussions')
          .orderBy('timestamp', descending: true) // Ordering by timestamp
          .get();

      // Map the documents to a list of DiscussionModel objects
      return discussionsSnapshot.docs.map((doc) {
        return DiscussionModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching discussions: $e');
      return [];
    }
  }

  // Method to add a comment to a specific discussion
  Future<void> addCommentToDiscussion(String discussionId, CommentModel comment) async {
    try {
      // Create the comment in the specific discussion's sub-collection
      await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussionId)
          .collection('comments')
          .doc(comment.commentId) // Use commentId as document ID
          .set(comment.toMap());

      // Optionally, update the discussion to increment the comment count
      await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussionId)
          .update({'noOfComments': FieldValue.increment(1)});

      print('Comment added successfully');
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  // Method to fetch comments for a specific discussion
  Future<List<CommentModel>> fetchCommentsForDiscussion(String discussionId) async {
    try {
      final QuerySnapshot commentsSnapshot = await FirebaseFirestore.instance
          .collection('discussions')
          .doc(discussionId)
          .collection('comments')
          .get();

      // Map the documents to a list of CommentModel objects
      return commentsSnapshot.docs.map((doc) {
        return CommentModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching comments: $e');
      return [];
    }
  }
}
