import 'dart:convert';

class RemoteModelVariables {
  String? name;
  String? filename;
  String? content;

  RemoteModelVariables({
    this.name,
    this.filename,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'filename': filename,
      'content': content,
    };
  }

  factory RemoteModelVariables.fromMap(Map<String, dynamic> map) {
    return RemoteModelVariables(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteModelVariables.fromJson(String source) =>
      RemoteModelVariables.fromMap(json.decode(source));
}
