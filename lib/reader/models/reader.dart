import 'dart:convert';

import 'package:letterbookd/reader/models/readerpreferences.dart';

Reader readerFromJson(String str) => Reader.fromJson(json.decode(str));

String readerToJson(Reader data) => json.encode(data.toJson());

class ReaderElement {
  int id;
  int userId;
  String displayName;
  String bio;
  int profilePicture;
  int personalLibraryId;
  int preferencesId;
  Preferences preferences;

  ReaderElement({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.bio,
    required this.profilePicture,
    required this.personalLibraryId,
    required this.preferencesId,
    required this.preferences,
  });

  factory ReaderElement.fromJson(Map<String, dynamic> json) {
    return ReaderElement(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      displayName: json["display_name"] ?? "",
      bio: json["bio"] ?? "",
      profilePicture: json["profile_picture"] ?? 0,
      personalLibraryId: json["personal_library_id"] ?? 0,
      preferencesId: json["preferences_id"] ?? 0,
      preferences: Preferences.fromJson(json["preferences"]) ??
          Preferences(shareReviews: false, shareLibrary: false),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "display_name": displayName,
        "bio": bio,
        "profile_picture": profilePicture,
        "personal_library_id": personalLibraryId,
        "preferences_id": preferencesId,
      };
}

class ReaderPreference {
  int id;
  bool shareReviews;
  bool shareLibrary;

  ReaderPreference({
    required this.id,
    required this.shareReviews,
    required this.shareLibrary,
  });

  factory ReaderPreference.fromJson(Map<String, dynamic> json) =>
      ReaderPreference(
        id: json["id"],
        shareReviews: json["share_reviews"],
        shareLibrary: json["share_library"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "share_reviews": shareReviews,
        "share_library": shareLibrary,
      };
}

class Reader {
  List<ReaderElement> readers;
  List<ReaderPreference> readerPreferences;

  Reader({
    required this.readers,
    required this.readerPreferences,
  });

  factory Reader.fromJson(Map<String, dynamic> json) {
    var readersJson = json["readers"];
    if (readersJson is List) {
      // If readersJson is a list, use it as is
      return Reader(
        readers: List<ReaderElement>.from(
            readersJson.map((x) => ReaderElement.fromJson(x["fields"]))),
        readerPreferences: List<ReaderPreference>.from(
            json["reader_preferences"]
                .map((x) => ReaderPreference.fromJson(x))),
      );
    } else if (readersJson is Map) {
      // If readersJson is a map, wrap it in a list
      return Reader(
        readers: [ReaderElement.fromJson(readersJson["fields"])],
        readerPreferences: List<ReaderPreference>.from(
            json["reader_preferences"]
                .map((x) => ReaderPreference.fromJson(x))),
      );
    } else {
      throw const FormatException("Invalid 'readers' field");
    }
  }

  Map<String, dynamic> toJson() => {
        "readers": List<dynamic>.from(readers.map((x) => x.toJson())),
        "reader_preferences":
            List<dynamic>.from(readerPreferences.map((x) => x.toJson())),
      };
}
