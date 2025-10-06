import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/data/baseurl.dart';
import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/review_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'package:restaurant_app/utils/header_delegate.dart';
import 'package:restaurant_app/utils/jenis_menu.dart';
import 'package:restaurant_app/widget/card_item_menu.dart';
import 'package:restaurant_app/widget/listtile_review.dart';

class DetailScreen extends StatefulWidget {
  final String idResto;
  const DetailScreen({super.key, required this.idResto});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController description = TextEditingController();
  bool isFavourite = false;
  void favouriteChek() {}
  @override
  void initState() {
    super.initState();
    context.read<DetailRestaurantProvider>().getDatadetail(widget.idResto);
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, values, child) {
            return switch (values.status) {
              Statussuksesdetail(data: var data) => CustomScrollView(
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
                          background: Hero(
                            tag: 'hero${data.restaurants.pictureId}',
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                "${Baseurl.imageUrl}/${data.restaurants.pictureId}",
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 50,
                          bottom: -20,
                          child: CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              icon:
                                  context.watch<DatabaseProvider>().isCheck(
                                    widget.idResto,
                                  )
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite),
                              onPressed: () {
                                final cek = context
                                    .read<DatabaseProvider>()
                                    .isCheck(widget.idResto);
                                Logger().d(cek);
                                if (!context.read<DatabaseProvider>().isCheck(
                                  widget.idResto,
                                )) {
                                  context.read<DatabaseProvider>().saveFavResto(
                                    Restoran(
                                      id: data.restaurants.id,
                                      name: data.restaurants.name,
                                      description: data.restaurants.description,
                                      pictureId: data.restaurants.pictureId,
                                      city: data.restaurants.city,
                                      rating: data.restaurants.rating,
                                    ),
                                  );
                                } else {
                                  context
                                      .read<DatabaseProvider>()
                                      .deleteFavoritRestran(widget.idResto);
                                }

                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) =>
                                      Consumer<DatabaseProvider>(
                                        builder: (context, value, child) {
                                          return switch (value.status) {
                                            StatussuksesloaDatabase(
                                              message: var message,
                                            ) =>
                                              AlertDialog(
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actionsPadding: EdgeInsets.only(
                                                  top: 10,
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(message),
                                                          OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: const Text(
                                                              "OK",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Statuserror(message: var message) =>
                                              AlertDialog(
                                                actions: [
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Text(message),
                                                        OutlinedButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                context,
                                                              ),
                                                          child: const Text(
                                                            "OK",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            _ => const AlertDialog(
                                              actions: [
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          };
                                        },
                                      ),
                                );
                              },
                            ),
                          ),
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
                              data.restaurants.name,
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
                                  "${data.restaurants.city}, ${data.restaurants.address}",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Card(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data.restaurants.kategori[index].name,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: data.restaurants.kategori.length,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Theme.of(context).colorScheme.onSecondary,
                            child: Text(
                              data.restaurants.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Makanan",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: data.restaurants.menu.food.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => CardItemMenu(
                                jenis: JenisMenu.makanan,
                                namamenu:
                                    data.restaurants.menu.food[index].name,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "minuman",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: data.restaurants.menu.drinks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => CardItemMenu(
                                jenis: JenisMenu.minuman,
                                namamenu:
                                    data.restaurants.menu.drinks[index].name,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Review",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 20),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 280,
                              maxHeight: 300,
                              minWidth: 400,
                              maxWidth: 450,
                            ),
                            child: Consumer<ReviewProvider>(
                              builder: (context, postreview, child) {
                                return Card(
                                  shadowColor: Theme.of(
                                    context,
                                  ).colorScheme.secondaryContainer,
                                  borderOnForeground: true,
                                  elevation: 10,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("tuliskan komentar anda"),
                                        const SizedBox(height: 10),
                                        TextField(
                                          controller: username,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Username"),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: description,
                                          maxLines: 3,
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                            label: Text("Deskripsi"),
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        OutlinedButton(
                                          onPressed: () {
                                            Logger().d(data.restaurants.id);
                                            postreview.onSubmit(
                                              username.text,
                                              description.text,
                                              data.restaurants.id,
                                            );
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) => Consumer<ReviewProvider>(
                                                builder:
                                                    (
                                                      context,
                                                      value,
                                                      child,
                                                    ) => switch (value.status) {
                                                      StatussuksesPostreview(
                                                        response: var response,
                                                      ) =>
                                                        AlertDialog(
                                                          title: Text("Review"),
                                                          actions: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  response
                                                                      .message,
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                      context,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "OK",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      Statuserror(
                                                        message: var message,
                                                      ) =>
                                                        AlertDialog(
                                                          title: Text(
                                                            "terjadi kesalahan",
                                                          ),
                                                          actions: [
                                                            Text(message),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        ),
                                                      _ => Center(
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      ),
                                                    },
                                              ),
                                            );
                                          },
                                          child: const Text("Kirim"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemBuilder: (context, index) =>
                        ListtileReview(review: data.restaurants.review[index]),
                    itemCount: data.restaurants.review.length,
                  ),
                ],
              ),

              Statuserror(message: var message) => Center(
                child: Column(
                  children: [
                    Text("$message silahkan coba lagi"),
                    OutlinedButton(
                      onPressed: () {
                        context.read<DetailRestaurantProvider>().getDatadetail(
                          widget.idResto,
                        );
                      },
                      child: const Text("coba lagi"),
                    ),
                  ],
                ),
              ),
              _ => Center(child: const CircularProgressIndicator()),
            };
          },
        ),
      ),
    );
  }
}
