// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class Threads {
  List<Thread>? threads;
  List<Thread>? threadsByLike;
  Threads({this.threads});

  Threads.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = <Thread>[];
      json['threads'].forEach((v) {
        threads!.add(Thread.fromJson(v));
      });
    }
    if (json['threads_by_like'] != null) {
      threadsByLike = <Thread>[];
      json['threads_by_like'].forEach((v) {
        threadsByLike!.add(new Thread.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (threads != null) {
      data['threads'] = threads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thread {
  String? model;
  int? pk;
  Fields? fields;

  Thread({this.model, this.pk, this.fields});

  Thread.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fields != null) {
      data['fields'] = this.fields!.toJson();
    }
    return data;
  }
}

class Fields {
  String? title;
  String? content;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Fields(
      {this.title,
      this.content,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Fields.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
