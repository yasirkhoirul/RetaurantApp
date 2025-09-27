import 'package:flutter/material.dart';

class ListtileReview extends StatelessWidget {
  const ListtileReview({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("Nama orang", style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(
        "ini adalah review dari orang tersebut sedikit panjang tapi bisa lah tak apa apap lalalallala",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
