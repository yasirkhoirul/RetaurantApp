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
              ItemHeader(
                title: "Notifikasi Restoran",
                switchvalue: values.setting!.notif,
                onSwitch: (value) async {
                  await values.saveData(
                    Setting(notif: value, theme: values.setting!.theme),
                  );
                  await values.getdata();
                },
              ),
              ItemHeader(
                title: "Tema",
                switchvalue: values.setting!.theme,
                onSwitch: (value) async {
                  await values.saveData(
                    Setting(notif: values.setting!.notif, theme: value),
                  );
                  await values.getdata();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemHeader extends StatelessWidget {

  final String title;
  final Function(bool)? onSwitch;
  final bool switchvalue;

  const ItemHeader({
    super.key,
    required this.onSwitch,
    required this.switchvalue,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: Headerlistrestorandelegate(
        maxheight: 80,
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
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 5),
                  Text(
                    switchvalue?"$title dihidupkan":"$title dimatikan",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Switch(value: switchvalue, onChanged: onSwitch),
            ],
          ),
        ),
      ),
    );
  }
}
