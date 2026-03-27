class Quote {
  final int id;
  final String content;
  final String author;
  final String theme;
  
  Quote({
    required this.id,
    required this.content,
    required this.author,
    required this.theme,
  });
  
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      theme: json['theme'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'theme': theme,
    };
  }
}