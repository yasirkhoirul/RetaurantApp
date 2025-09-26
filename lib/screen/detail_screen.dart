import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget{
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 10,bottom: 24),
              title: Image.network("",errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),),
            ),
          )
        ],
      ),
    );
  }
}