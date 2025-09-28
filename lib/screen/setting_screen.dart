import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/settings_provider.dart';
import 'package:restaurant_app/utils/header_delegate.dart';

class SettingScreen extends StatelessWidget {
  final bool notif = false;
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, values, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Settings"),
                  titlePadding: EdgeInsets.only(left: 10, bottom: 10),
                ),
              ),
              SliverPersistentHeader(
                delegate: Headerlistrestorandelegate(
                  maxheight: 120,
                  minheight: 80,
                  anak: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Restaurant Notification",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Enable Notification",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Switch(
                          value: values.notifiacion,
                          onChanged: (value) {
                            values.setNotification(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
