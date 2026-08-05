class ClassModel {
  final int classNumber;
  final String label;
  final String emoji;
  final String group;

  const ClassModel({
    required this.classNumber,
    required this.label,
    required this.emoji,
    required this.group,
  });
}

class SubjectModel {
  final String name;
  final String emoji;
  final String color;
  final List<String> topics;

  const SubjectModel({
    required this.name,
    required this.emoji,
    required this.color,
    required this.topics,
  });
}
