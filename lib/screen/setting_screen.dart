import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/model/setting.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/utils/header_delegate.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final bool notif = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<SettingProvider>().getdata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
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
                          value: values.setting!.notif,
                          onChanged: (value) async {
                            await values.saveData(
                              Setting(
                                notif: value,
                                theme: values.setting!.theme,
                              ),
                            );
                            await values.getdata();
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
