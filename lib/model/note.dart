class Note {
  final String id;
  final String title;
  final String content;
  int favorite;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.favorite = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'favorite': favorite,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      favorite: map['favorite'],
    );
  }
}
