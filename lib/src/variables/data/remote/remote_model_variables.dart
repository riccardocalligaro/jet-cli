import 'dart:convert';

class RemoteModelVariables {
  String? name;
  RemoteModelVariables({
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
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
