class Note {
  final int id;
  final String icon;
  String title;
  List<String> tasks;

  Note({
    required this.id,
    required this.icon,
    required this.title,
    this.tasks = const [],
  });
}
