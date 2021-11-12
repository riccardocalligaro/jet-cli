import 'package:flutter/foundation.dart';



@immutable
class TodoRemoteModel {

  const TodoRemoteModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  final int userId;
  final int id;
  final String title;
  final bool completed;

  

  factory TodoRemoteModel.fromJson(Map<String,dynamic> json) => TodoRemoteModel(
    userId: json['userId'] as int,
    id: json['id'] as int,
    title: json['title'] as String,
    completed: json['completed'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed
  };

  TodoRemoteModel clone() => TodoRemoteModel(
    userId: userId,
    id: id,
    title: title,
    completed: completed
  );


  TodoRemoteModel copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed
  ,}) => TodoRemoteModel(
    userId: userId ?? this.userId,
    id: id ?? this.id,
    title: title ?? this.title,
    completed: completed ?? this.completed,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TodoRemoteModel && userId == other.userId && id == other.id && title == other.title && completed == other.completed;

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode ^ completed.hashCode;
}
