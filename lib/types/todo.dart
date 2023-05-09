class TodoItem {
  final String title;
  final String description;
  final DateTime? dueDate;
  final String? location;
  final String? tag;

  TodoItem({
    required this.title,
    required this.description,
    this.dueDate,
    this.location,
    this.tag,
  });
}
