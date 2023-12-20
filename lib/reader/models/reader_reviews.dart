class Review {
  final int id;
  final String bookTitle;
  final double starsRating;
  final String statusOnReview;
  final String datePosted;
  final String reviewText;

  Review({
    required this.id,
    required this.bookTitle,
    required this.starsRating,
    required this.statusOnReview,
    required this.datePosted,
    required this.reviewText,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      bookTitle: json['book_title'],
      starsRating: json['stars_rating'].toDouble(),
      statusOnReview: json['status_on_review'],
      datePosted: json['date_posted'],
      reviewText: json['review_text'],
    );
  }
}
