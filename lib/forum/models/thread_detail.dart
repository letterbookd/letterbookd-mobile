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
        replies!.add(Replies.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    userLiked = json['user_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thread_content'] = threadContent;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    data['user_liked'] = userLiked;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['created_by'] = createdBy;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdBy;
    return data;
  }
}
