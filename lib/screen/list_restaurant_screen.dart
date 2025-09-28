import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/customlist.dart';

class ListRestaurantScreen extends StatelessWidget {
  const ListRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Customlistrestoran()));
  }
}
