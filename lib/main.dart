import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/list_restaurant_screen.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: ListRestaurantScreen(),
        ),
      ),
    );
  }
}
