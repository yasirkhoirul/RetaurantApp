import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restoranlist_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'package:restaurant_app/widget/customlist.dart';

class ListRestaurantScreen extends StatefulWidget {
  const ListRestaurantScreen({super.key});

  @override
  State<ListRestaurantScreen> createState() => _ListRestaurantScreenState();
}

class _ListRestaurantScreenState extends State<ListRestaurantScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<RestoranlistProvider>().fetchdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestoranlistProvider>(
        builder: (context, valuse, child) {
          return SafeArea(
            child: switch (valuse.status) {
              Statussukses(datarestoran: var data) => Customlistrestoran(
                title: "Restaurant",
                datalist: data.restaurant,
              ),
              Statuserror(message: var message) => Center(
                child: Column(
                  children: [
                    Text(message),
                    OutlinedButton(
                      onPressed: () {
                        context.read<RestoranlistProvider>().fetchdata();
                      },
                      child: const Text("coba lagi"),
                    ),
                  ],
                ),
              ),
              _ => Center(child: CircularProgressIndicator()),
            },
          );
        },
      ),
    );
  }
}
