class ReviewModel {
  final String reviewerName;
  final double rating; // Use double for fractional ratings
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'reviewerName': reviewerName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewerName: map['reviewerName'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      comment: map['comment'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }
}
