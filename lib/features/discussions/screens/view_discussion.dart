import 'package:flutter/material.dart';
import '../models/discussion.dart'; // Import your DiscussionModel
import '../models/comments.dart'; // Import your CommentModel
import 'package:pawpal/features/discussions/services/discussion_services.dart'; // Import FirestoreService for fetching and adding comments

class ViewDiscussionPage extends StatefulWidget {
  final DiscussionModel discussion;

  const ViewDiscussionPage({super.key, required this.discussion});

  @override
  State<ViewDiscussionPage> createState() => _ViewDiscussionPageState();
}

class _ViewDiscussionPageState extends State<ViewDiscussionPage> {
  final TextEditingController _commentController = TextEditingController();
  List<CommentModel> comments = []; // List to hold fetched comments
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final fetchedComments =
          await FirestoreService().fetchCommentsForDiscussion(widget.discussion.discussionId);
      setState(() {
        comments = fetchedComments;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<void> _addComment(String content) async {
    // Create a new CommentModel instance with a unique commentId
    final commentId = DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID
    final newComment = CommentModel(
      commentId: commentId,
      content: content,
      timestamp: DateTime.now(),
    );

    try {
      // Call the Firestore service to add the comment
      await FirestoreService().addCommentToDiscussion(widget.discussion.discussionId, newComment);

      // Add the new comment to the local list for UI update
      setState(() {
        comments.add(newComment);
      });
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'), // Set title to 'Discussions'
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display discussion title as plain text
            Text(
              widget.discussion.title, // Use the title from the discussion model
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0, // Increased font size for emphasis
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.discussion.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const Text(
              'Comments',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          title: Text(comment.content),
                          subtitle: Text(
                              '${comment.timestamp.toLocal()}'.split(' ')[0]), // Display date
                        );
                      },
                    ),
            ),
            const SizedBox(height: 8.0), // Space between comments and input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), // Space between TextField and button
                FloatingActionButton(
                  onPressed: () async {
                    if (_commentController.text.isNotEmpty) {
                      await _addComment(_commentController.text);
                      _commentController.clear();
                    }
                  },
                  backgroundColor: Colors.amber[600], // Set the button color to yellow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add_comment),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
