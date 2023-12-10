// To parse this JSON data, do
//
//     final libraryBook = libraryBookFromJson(jsonString);

import 'dart:convert';

List<LibraryBook> libraryBookFromJson(String str) => List<LibraryBook>.from(
    json.decode(str).map((x) => LibraryBook.fromJson(x)));

String libraryBookToJson(List<LibraryBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LibraryBook {
  Model model;
  int pk;
  Fields fields;

  LibraryBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory LibraryBook.fromJson(Map<String, dynamic> json) => LibraryBook(
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
  int fieldsLibrary;
  int book;
  int trackingStatus;
  bool isFavorited;
  bool isReviewed;

  Fields({
    required this.fieldsLibrary,
    required this.book,
    required this.trackingStatus,
    required this.isFavorited,
    required this.isReviewed,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        fieldsLibrary: json["library"],
        book: json["book"],
        trackingStatus: json["tracking_status"],
        isFavorited: json["is_favorited"],
        isReviewed: json["is_reviewed"],
      );

  Map<String, dynamic> toJson() => {
        "library": fieldsLibrary,
        "book": book,
        "tracking_status": trackingStatus,
        "is_favorited": isFavorited,
        "is_reviewed": isReviewed,
      };
}

enum Model { LIBRARY_LIBRARYBOOK }

final modelValues =
    EnumValues({"library.librarybook": Model.LIBRARY_LIBRARYBOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
