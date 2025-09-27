import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/jenis_menu.dart';

class CardItemMenu extends StatelessWidget {
  final JenisMenu jenis;
  const CardItemMenu({required this.jenis, super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                jenis.jenis == JenisMenu.makanan.jenis
                    ? Icons.food_bank
                    : Icons.local_drink,
              ),
              Text("menu",style: Theme.of(context).textTheme.titleSmall,),
              Text("nama menu",style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
      ),
    );
  }
}
