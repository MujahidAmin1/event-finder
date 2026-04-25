class Event {
  final int id;
  final String title;
  final String category;
  final String date;
  final String time;
  final String location;
  final String imageUrl;
  final String distance;
  final String description;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.distance,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      distance: json['distance'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'time': time,
      'location': location,
      'imageUrl': imageUrl,
      'distance': distance,
      'description': description,
    };
  }
}