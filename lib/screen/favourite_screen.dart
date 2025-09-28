import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/customlist.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Customlistrestoran(title: "Favourite",));
  }
}
