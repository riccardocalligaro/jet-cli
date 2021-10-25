import 'dart:convert';

class RemoteModelVariables {
  String? name;
  String? filename;

  RemoteModelVariables({
    this.name,
    this.filename,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'filename': filename,
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
