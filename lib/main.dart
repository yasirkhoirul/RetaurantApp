import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/provider/bottomnav_provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/restoranlist_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/screen/detail_screen.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/service/setting_service.dart';
import 'package:restaurant_app/service/sqlite_service.dart';
import 'package:restaurant_app/service/timezone_notification_service.dart';
import 'package:restaurant_app/static/route.dart';
import 'package:restaurant_app/style/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Navigationprovider()),
        Provider(create: (context) => Apiservice()),
        ChangeNotifierProvider(
          create: (context) =>
              RestoranlistProvider(api: context.read<Apiservice>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchbarProvider(api: context.read<Apiservice>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DetailRestaurantProvider(api: context.read<Apiservice>()),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(context.read<Apiservice>()),
        ),
        Provider(create: (context) => SqliteService()),
        ChangeNotifierProvider(
          create: (context) =>
              DatabaseProvider(sqlite: context.read<SqliteService>()),
        ),
        Provider(create: (context) => SettingService(prefs)),
        Provider(
          create: (context) => TimezoneNotificationService()
            ..init()
            ..configureLocalTImezone(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SettingProvider(settingService: context.read<SettingService>())
                ..getdata(),
        ),

        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<TimezoneNotificationService>(),
          ),
        ),
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
      themeMode: context.watch<SettingProvider>().setting!.theme
          ? ThemeMode.light
          : ThemeMode.dark,
      initialRoute: Restoreanroute.home.rute,
      routes: {
        Restoreanroute.home.rute: (context) => HomeScreen(),
        Restoreanroute.detail.rute: (context) => DetailScreen(
          idResto: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
