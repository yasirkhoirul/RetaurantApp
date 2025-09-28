import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bottomnav_provider.dart';
import 'package:restaurant_app/screen/favourite_screen.dart';
import 'package:restaurant_app/screen/list_restaurant_screen.dart';
import 'package:restaurant_app/screen/setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<Navigationprovider>(
      builder: (context, values, child) {
        return Scaffold(
          body: switch (values.indexNav) {
            0 => const ListRestaurantScreen(),
            1 => const FavouriteScreen(),
            _ => const SettingScreen(),
          },
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 12,
            unselectedFontSize: 8,
            onTap: (value) => values.setIndex(value),
            currentIndex: values.indexNav,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant, size: 20),
                label: "Restaurant",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 20),
                label: "Favourite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 20),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
