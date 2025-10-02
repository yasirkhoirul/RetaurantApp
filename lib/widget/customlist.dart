import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:restaurant_app/provider/searchbar_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'package:restaurant_app/utils/header_delegate.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

class Customlistrestoran extends StatefulWidget {
  final int indexbotnav;
  final String title;
  final List<Restoran> datalist;
  const Customlistrestoran({
    super.key,
    required this.title,
    required this.datalist,
    required this.indexbotnav
  });//

  @override
  State<Customlistrestoran> createState() => _CustomlistrestoranState();
}

class _CustomlistrestoranState extends State<Customlistrestoran> {
  late TextEditingController text;
  @override
  void initState() {
    super.initState();
    text = TextEditingController(text: context.read<SearchbarProvider>().data);
  }

  @override
  void dispose() {
    super.dispose();
    text.dispose();
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),

        widget.indexbotnav == 0?SliverPersistentHeader(
          pinned: true,
          delegate: Headerlistrestorandelegate(
            maxheight: 120,
            minheight: 50,
            anak: Center(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SearchBar(
                  controller: text,
                  onTapOutside: (event) => Logger().d(ModalRoute.of(context)?.settings.name),
                  onChanged: (value) =>
                      context.read<SearchbarProvider>().setdata(value),
                  onSubmitted: (value) =>
                      context.read<SearchbarProvider>().searchItem(),
                  hintText: "Cari Restoran",
                  leading: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ):SliverToBoxAdapter(),
        Consumer<SearchbarProvider>(
          builder: (context, values, child) {
            return switch (values.datalistsearch) {
              StatussuksesSearch(datarestoran: var data) => SliverList.builder(
                itemBuilder: (context, index) =>
                    CardItemRestoranlist(dataresto: data.restaurant[index]),
                itemCount: data.restaurant.length,
              ),
              Statuserror(message: var message) => SliverToBoxAdapter(
                child: Center(child: Text(message)),
              ),
              StatusIdle() => SliverList.builder(
                itemBuilder: (context, index) =>
                    CardItemRestoranlist(dataresto: widget.datalist[index]),
                itemCount: widget.datalist.length,
              ),
              _ => SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
            };
          },
        ),
      ],
    );
  }
}
