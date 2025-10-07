import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/model/setting.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/static/status.dart';
import 'package:restaurant_app/utils/header_delegate.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  Future checkpermission() async {
    Logger().d("dijalankan");
    final setting = context.read<SettingProvider>();
    Logger().d("dijalankan 2");
    final local = context.read<LocalNotificationProvider>();
    Logger().d("dijalankan 3");
    await local.checkPermission();
    final bool permission = local.permission??false;
    Logger().d("permissionnya adalah $permission");
    if (!permission && mounted) {
      Logger().d("masuk !permission");
      local.cancelAllnotif();
      await setting.saveData(
        Setting(notif: false, theme: setting.setting?.theme ?? false),
      );
    }
    Logger().d("dijalankan 4");
    await setting.getdata();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _requestPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      Logger().d("resumed");
      checkpermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, values, child) {
        final permission = context
            .watch<LocalNotificationProvider>()
            .permission;
        return switch (values.status) {
          StatussuksesloaDatabase() => Scaffold(
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
                  onSwitch: permission ?? false
                      ? (value) async {
                          if (value) {
                            await values.saveData(
                            Setting(notif: value, theme: values.setting!.theme),
                            );
                            _scheduleDailytenAMNotification();
                            await values.getdata();
                          } else {
                            await values.saveData(
                            Setting(notif: value, theme: values.setting!.theme),
                            );
                            if (context.mounted) {
                              await context.read<LocalNotificationProvider>().cancelAllnotif();
                            }
                            await values.getdata();
                          }
                        }
                      : null,
                ),
                permission ?? false
                    ? SliverToBoxAdapter()
                    : SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const Text("Perizinn di tolak"),
                            Text(
                              "Untuk mengaktifkan pengingat, aktifkan izin notifikasi "
                              "melalui Pengaturan aplikasi.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
          ),
          _ => const CircularProgressIndicator(),
        };
      },
    );
  }

  Future<void> _requestPermission() async {
    final req = context.read<LocalNotificationProvider>();
    await req.requestPermissions();
    if (mounted) {
      checkpermission();
    }
  }

  Future<void> _scheduleDailytenAMNotification() async {
    context
        .read<LocalNotificationProvider>()
        .scheduleDailytenAMNotification();
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
    required this.title,
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
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 5),
                  Text(
                    switchvalue ? "$title dihidupkan" : "$title dimatikan",
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
