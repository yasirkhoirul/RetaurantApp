import 'package:flutter/material.dart';
import 'package:restaurant_app/api/data/baseurl.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:restaurant_app/static/route.dart';

class CardItemRestoranlist extends StatelessWidget {
  final Restoran dataresto;
  const CardItemRestoranlist({super.key, required this.dataresto});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 120, minHeight: 100),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Restoreanroute.detail.rute,
              arguments: dataresto.id,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Hero(
                      tag: "hero${dataresto.pictureId}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "${Baseurl.imageUrl}/${dataresto.pictureId}",
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataresto.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 20),
                              Text(
                                dataresto.city,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 20),
                          Text(
                            dataresto.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
