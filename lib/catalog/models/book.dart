// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int isbn13;
    String title;
    String authors;
    String categories;
    String thumbnail;
    String description;
    int publishedYear;
    int pageCount;
    double overallRating;
    int favoritesCount;

    Fields({
        required this.isbn13,
        required this.title,
        required this.authors,
        required this.categories,
        required this.thumbnail,
        required this.description,
        required this.publishedYear,
        required this.pageCount,
        required this.overallRating,
        required this.favoritesCount,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn13: json["isbn13"],
        title: json["title"],
        authors: json["authors"],
        categories: json["categories"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        publishedYear: json["published_year"],
        pageCount: json["page_count"],
        overallRating: json["overall_rating"],
        favoritesCount: json["favorites_count"],
    );

    Map<String, dynamic> toJson() => {
        "isbn13": isbn13,
        "title": title,
        "authors": authors,
        "categories": categories,
        "thumbnail": thumbnail,
        "description": description,
        "published_year": publishedYear,
        "page_count": pageCount,
        "overall_rating": overallRating,
        "favorites_count": favoritesCount,
    };
}

enum Model {
    // ignore: constant_identifier_names
    CATALOG_BOOK
}

final modelValues = EnumValues({
    "catalog.book": Model.CATALOG_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}