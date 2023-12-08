class Threads {
  List<Thread>? threads;

  Threads({this.threads});

  Threads.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = <Thread>[];
      json['threads'].forEach((v) {
        threads!.add(new Thread.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.threads != null) {
      data['threads'] = this.threads!.map((v) => v.toJson()).toList();
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
    fields =
        json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
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
  int? createdBy;
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
