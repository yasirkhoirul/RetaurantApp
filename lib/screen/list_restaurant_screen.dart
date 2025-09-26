import 'package:flutter/material.dart';
import 'package:restaurant_app/widget/card_item_restoranlist.dart';

class ListRestaurantScreen extends StatelessWidget{
  const ListRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: 
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 10,bottom: 24),
                title: Text("Restoran",style: Theme.of(context).textTheme.headlineSmall,),
              ),
            ),
            SliverList.builder(itemBuilder: (context, index) => CardItemRestoranlist(),itemCount: 5,)
          ],
        )
      ),
    );
  }
}