// comment_dialog.dart
import 'package:flutter/material.dart';
import 'package:pawpal/features/discussions/models/comments.dart'; // Update with the correct import
import 'package:pawpal/core/services/firestore_service.dart'; // Update with the correct import

class CommentDialog extends StatefulWidget {
  final String discussionId;

  const CommentDialog({super.key, required this.discussionId});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  final TextEditingController _controller = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Comment'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Write your comment here...'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Call the function to add comment
            if (_controller.text.isNotEmpty) {
              // Create the CommentModel
              final comment = CommentModel(
                content: _controller.text,
                timestamp: DateTime.now(),
              );
              // Use the FirestoreService to add the comment
              _firestoreService.addCommentToDiscussion(widget.discussionId, comment);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
