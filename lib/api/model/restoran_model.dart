class Restoranlist {
  final bool error;
  final String message;
  final int count;
  final List<Restoran> restaurant;
  Restoranlist({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurant,
  });

  factory Restoranlist.fromjson(Map<String, dynamic> json) {
    return Restoranlist(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurant: json['restaurants'] != null
          ? (json['restaurants'] as List)
                .map((e) => Restoran.fromjson(e))
                .toList()
          : [],
    );
  }
}

class Restoran {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  Restoran({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  factory Restoran.fromjson(Map<String, dynamic> json) {
    return Restoran(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}

class SearchRestoran {
  final bool error;
  final int founded;
  final List<Restoran> restaurant;
  const SearchRestoran(this.error, this.founded, this.restaurant);
  factory SearchRestoran.fromjson(Map<String, dynamic> json) {
    return SearchRestoran(
      json['error'],
      json['founded'],
      (json['restaurants'] as List).map((e) => Restoran.fromjson(e)).toList(),
    );
  }
}
