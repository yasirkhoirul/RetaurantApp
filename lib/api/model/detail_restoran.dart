class DetailRestoran {
  final bool error;
  final String message;
  final ItemDetailRestaurant restaurants;
  DetailRestoran(this.error, this.message, this.restaurants);
  factory DetailRestoran.fromjson(Map<String, dynamic> json) {
    return DetailRestoran(
      json['error'],
      json['message'],
      ItemDetailRestaurant.fromjson(json['restaurant']),
    );
  }
}

class ItemDetailRestaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Categories> kategori;
  final Menu menu;
  final double rating;
  final List<Review> review;
  ItemDetailRestaurant({
    required this.id,
    required this.address,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.kategori,
    required this.menu,
    required this.rating,
    required this.review,
  });
  factory ItemDetailRestaurant.fromjson(Map<String, dynamic> json) {
    return ItemDetailRestaurant(
      id: json['id'],
      address: json['address'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      pictureId: json['pictureId'],
      kategori: (json['categories'] as List)
          .map((e) => Categories.fromjson(e))
          .toList(),
      menu: Menu.fromjson(json['menus']),
      rating: (json['rating'] as num).toDouble(),
      review: (json['customerReviews'] as List)
          .map((e) => Review.fromjson(e))
          .toList(),
    );
  }
}

class Categories {
  final String name;
  Categories(this.name);
  factory Categories.fromjson(Map<String, dynamic> json) {
    return Categories(json['name']);
  }
}

class Menu {
  final List<Food> food;
  final List<Drink> drinks;
  Menu(this.food, this.drinks);
  factory Menu.fromjson(Map<String, dynamic> json) {
    return Menu(
      (json['foods'] as List).map((e) => Food.fromjson(e)).toList(),
      (json['drinks'] as List).map((e) => Drink.fromjson(e)).toList(),
    );
  }
}

class Food {
  final String name;
  Food(this.name);
  factory Food.fromjson(Map<String, dynamic> json) {
    return Food(json['name']);
  }
}

class Drink {
  final String name;
  Drink(this.name);
  factory Drink.fromjson(Map<String, dynamic> json) {
    return Drink(json['name']);
  }
}

class Review {
  final String name;
  final String review;
  final String date;
  Review(this.name, this.review, this.date);
  factory Review.fromjson(Map<String, dynamic> json) {
    return Review(json['name'], json['review'], json['date']);
  }
}

class ReviewPostResponse {
  final bool error;
  final String message;
  final List<Review> customerReviews;
  ReviewPostResponse(this.error, this.message, this.customerReviews);
  factory ReviewPostResponse.fromjson(Map<String, dynamic> json) {
    return ReviewPostResponse(
      json['error'],
      json['message'],
      (json['customerReviews'] as List).map((e) => Review.fromjson(e)).toList(),
    );
  }
}

class ReviewPost {
  final String id;
  final String name;
  final String review;
  ReviewPost({required this.id, required this.name, required this.review});
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'review': review};
  }
}
