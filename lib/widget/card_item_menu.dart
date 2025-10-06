import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/jenis_menu.dart';

class CardItemMenu extends StatelessWidget {
  final JenisMenu jenis;
  final String namamenu;
  const CardItemMenu({required this.jenis, super.key, required this.namamenu});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
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
                Text(
                  jenis.jenis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  namamenu,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
