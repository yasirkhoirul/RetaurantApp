import 'package:flutter/material.dart';
import 'package:restaurant_app/static/route.dart';

class CardItemRestoranlist extends StatelessWidget {
  const CardItemRestoranlist({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 120, minHeight: 100),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Restoreanroute.detail.rute);
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
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/14",
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
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
                            "Restoran 1",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 20),
                              Text(
                                "Lokasi",
                                style: Theme.of(context).textTheme.labelSmall,
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
                            "4,6",
                            style: Theme.of(context).textTheme.labelSmall,
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
