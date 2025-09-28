import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/utils/header_delegate.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

class Customlistrestoran extends StatefulWidget {
  final String title;
  const Customlistrestoran({super.key,required this.title});

  @override
  State<Customlistrestoran> createState() => _CustomlistrestoranState();
}

class _CustomlistrestoranState extends State<Customlistrestoran> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
              widget.title,
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
                child: Center(
                  child: SearchBar(
                    onChanged: (value) =>
                        context.read<SearchbarProvider>().setdata(value),
                    hintText: "Cari Restoran",
                    leading: Icon(Icons.search),
                  ),
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
    );
  }
}
