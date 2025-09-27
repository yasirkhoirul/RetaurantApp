import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/header_delegate.dart';
import 'package:restaurant_app/utils/jenis_menu.dart';
import 'package:restaurant_app/widget/card_item_menu.dart';
import 'package:restaurant_app/widget/listtile_review.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            
            flexibleSpace: Stack(
              clipBehavior: Clip.none,
              children: [
                FlexibleSpaceBar(
                  background: ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/14",
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: -20,
                  child: CircleAvatar(radius: 20, child: Icon(Icons.favorite)),
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            delegate: Headerlistrestorandelegate(
              maxheight: 120,
              minheight: 110,
              anak: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant nama",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, size: 20),
                        SizedBox(width: 10),
                        Text(
                          "lokasi ada di address",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Text(" genre ",style: Theme.of(context).textTheme.labelMedium,),
                        itemCount: 3,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "lorem ipsum balldflsdlflsdflsdf sldfalsdjflksjdflkasd sdlkfjlsadjflkjsdfl sdflakj",
                    style: Theme.of(context).textTheme.bodyMedium,),
                    SizedBox(height: 20),
                    Text("Makanan", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CardItemMenu(jenis: JenisMenu.makanan),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("minuman", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            CardItemMenu(jenis: JenisMenu.minuman),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Review",style: Theme.of(context).textTheme.titleLarge,)
                  ],
                ),
              ),
            ),
          ),
          SliverList.builder(itemBuilder: (context, index) => const ListtileReview(),itemCount: 8,)
        ],
      ),
    );
  }
}
