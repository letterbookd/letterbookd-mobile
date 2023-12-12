// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class ThreadDetail {
  String? title;
  String? threadContent;
  List<Replies>? replies;
  List<Likes>? likes;
  bool? userLiked;

  ThreadDetail(
      {this.title,
      this.threadContent,
      this.replies,
      this.likes,
      this.userLiked});

  ThreadDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    threadContent = json['thread_content'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    userLiked = json['user_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thread_content'] = this.threadContent;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['user_liked'] = this.userLiked;
    return data;
  }
}

class Replies {
  String? content;
  String? createdBy;
  String? createdAt;

  Replies({this.content, this.createdBy});

  Replies.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class Likes {
  String? createdBy;

  Likes({this.createdBy});

  Likes.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    return data;
  }
}
