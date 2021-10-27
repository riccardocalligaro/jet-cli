class JSONOptions {
  final String name;
  final String? remoteModel;
  final String content;

  JSONOptions({
    required this.name,
    required this.content,
    this.remoteModel,
  });
}
