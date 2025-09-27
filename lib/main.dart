import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/list_restaurant_screen.dart';
import 'package:restaurant_app/style/theme.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TurisTheme.lightTheme,
      darkTheme: TurisTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: ChangeNotifierProvider(
            create: (context) => SearchbarProvider(),
            child: const DetailScreen(),
          ),
        ),
      ),
    );
  }
}
