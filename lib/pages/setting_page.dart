import 'package:crypto_price_list/notifier/app_state/app_state_notifier.dart';
import 'package:crypto_price_list/notifier/price_detail/price_detail_notifier.dart';
import 'package:crypto_price_list/notifier/price_list/price_list_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  AppStateProvider appStateProvider = GetIt.I.get<AppStateProvider>();

  final PriceDetailProvider priceDetailProvider = GetIt.instance
      .get<PriceDetailProvider>();
  final PriceListProvider priceListProvider = GetIt.I.get<PriceListProvider>();

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(appStateProvider).isDark;
    return Scaffold(
      appBar: AppBar(title: Text("Setting")),
      body: Column(
        children: [
          Card(
            child: SwitchListTile(
              title: Text("Dark Mode"),
              value: isDark,
              onChanged: (isDark) {
                ref.read(appStateProvider.notifier).changeTheme(isDark);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Clear Favourites"),
              leading: Icon(Icons.delete),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Delete Favourites"),
                      content: Text("Do you want to delete Favourites list?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("NO"),
                        ),
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(priceDetailProvider.notifier)
                                .clearFavourites();
                            ref
                                .read(priceListProvider.notifier)
                                .getFavouriteList();
                            Navigator.pop(context);
                          },
                          child: Text("YES"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
