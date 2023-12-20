// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
    String model;
    int pk;
    Fields fields;

    Review({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    int book;
    double starsRating;
    String statusOnReview;
    DateTime datePosted;
    String reviewText;

    Fields({
        required this.user,
        required this.book,
        required this.starsRating,
        required this.statusOnReview,
        required this.datePosted,
        required this.reviewText,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        starsRating: json["stars_rating"],
        statusOnReview: json["status_on_review"],
        datePosted: DateTime.parse(json["date_posted"]),
        reviewText: json["review_text"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "stars_rating": starsRating,
        "status_on_review": statusOnReview,
        "date_posted": datePosted.toIso8601String(),
        "review_text": reviewText,
    };
}
