import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/utils/header_delegate.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

class ListRestaurantScreen extends StatelessWidget {
  const ListRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              floating: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 10, bottom: 24),
                title: Text(
                  "Restoran",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: Headerlistrestorandelegate(
                maxheight: 120,
                minheight: 50,
                anak: Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SearchBar(
                          onChanged: (value) =>
                              context.read<SearchbarProvider>().setdata(value),
                          hintText: "Cari Restoran",
                          leading: Icon(Icons.search),
                        ),
                        Consumer<SearchbarProvider>(
                          builder: (context, value, child) {
                            return Text("hasilnya adalah ${value.data}");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) => CardItemRestoranlist(),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
