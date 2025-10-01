import 'package:flutter/material.dart';
import 'package:restaurant_app/api/model/detail_restoran.dart';

class ListtileReview extends StatelessWidget {
  final Review review;
  const ListtileReview({super.key, required this.review});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(review.name, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(
        review.review,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
