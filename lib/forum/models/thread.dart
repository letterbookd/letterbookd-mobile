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
        threadsByLike!.add(Thread.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['pk'] = pk;
    if (fields != null) {
      data['fields'] = fields!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
