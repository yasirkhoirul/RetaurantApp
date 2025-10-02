import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bottomnav_provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restoranlist_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'package:restaurant_app/widget/customlist.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<DatabaseProvider>().loadAllFavoritRestoran();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DatabaseProvider>(
          builder: (context, values, child) {
            Logger().d(context.read<Navigationprovider>().indexNav);
            return switch (values.status) {
              StatussuksesloaDatabase() => Customlistrestoran(
                title: "Favourite",
                datalist: values.restoran ?? [],
                indexbotnav: context.read<Navigationprovider>().indexNav,
              ),
              Statuserror(message: var message) => Column(
                children: [
                  Text(message),
                  OutlinedButton(
                    onPressed: () {
                      context.read<RestoranlistProvider>().fetchdata();
                    },
                    child: Text("silahkan coba lagi"),
                  ),
                ],
              ),
              _ => Center(child: CircularProgressIndicator()),
            };
          },
        ),
      ),
    );
  }
}
