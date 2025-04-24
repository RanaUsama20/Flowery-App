class SearchQuery {
  final String id;
  final String title;
  final DateTime dateTime;

  SearchQuery({
    required this.id,
    required this.title,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dateTime': dateTime.toIso8601String(),
      };

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
        id: json['id'],
        title: json['title'],
        dateTime: DateTime.parse(json['dateTime']),
      );
}
