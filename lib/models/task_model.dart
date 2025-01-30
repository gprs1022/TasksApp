class TaskModel {

  final String? id;
  final String? title;
  final String? description;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
  });


  factory TaskModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return TaskModel(
      id: documentId,
      title: map["title"] as String? ?? "",
      description: map["description"] as String? ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
    };
  }
}
