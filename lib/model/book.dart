const String tableBooks = 'books';

class BookFields {
  static final List<String> values = [
    /// Add all fields
    id, title, time, coverUrl, description
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String time = 'time';
  static const String coverUrl = 'cover_url';
  static const String description = 'description';
}

class Book {

  final int? id;
  final String title;
  final DateTime createdTime;
  final String coverUrl;
  final String description;

  const Book({
    this.id,
    required this.title,
    required this.createdTime,
    required this.coverUrl,
    required this.description
  });

  Book copy({
    int? id,
    String? title,
    DateTime? createdTime,
    String? coverUrl,
    String? description
  }) =>
    Book(
      id:id?? this.id,
      title: title?? this.title,
      createdTime: createdTime?? this.createdTime,
      coverUrl: coverUrl?? this.coverUrl,
      description: description?? this.description
    );

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    title: json[BookFields.title] as String,
    createdTime: json[BookFields.time] as DateTime,
    coverUrl: json[BookFields.coverUrl] as String,
    description: json[BookFields.description] as String
  );

  Map<String, Object?> toJson() => {
    BookFields.id: id,
    BookFields.title: title,
    BookFields.time: createdTime.toIso8601String(),
    BookFields.coverUrl: coverUrl,
    BookFields.description: description
  };

}