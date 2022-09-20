class Repository {
  final int id;
  final String name;
  final String description;
  final String createdAt;

  const Repository({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? 'No Description Available',
      createdAt: map['created_at'],
    );
  }
}
