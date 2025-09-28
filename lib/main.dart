import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bottomnav_provider.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/provider/settings_provider.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/static/route.dart';
import 'package:restaurant_app/style/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchbarProvider()),
        ChangeNotifierProvider(create: (context) => Navigationprovider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TurisTheme.lightTheme,
      darkTheme: TurisTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Restoreanroute.home.rute,
      routes: {
        Restoreanroute.home.rute: (context) => HomeScreen(),
        Restoreanroute.detail.rute: (context) => DetailScreen(),
      },
    );
  }
}
