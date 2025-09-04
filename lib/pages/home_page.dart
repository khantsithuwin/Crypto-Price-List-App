import 'package:crypto_price_list/pages/price_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../notifier/price_list/price_list_state_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final priceListProvider = PriceListProvider(() => PriceListStateNotifier());

  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<PriceListProvider>()) {
      GetIt.I.registerSingleton<PriceListProvider>(priceListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    StatefulNavigationShell shell = widget.shell;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          if (width >= 600)
            DefaultTabController(
              initialIndex: shell.currentIndex,
              length: 4,
              child: TabBar(
                onTap: (index) {
                  shell.goBranch(index);
                  if (index == 1) {
                    ref.read(priceListProvider.notifier).getFavouriteList();
                  }
                },
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.favorite), text: "Favourite"),
                  Tab(icon: Icon(Icons.newspaper_outlined), text: "News"),
                  Tab(icon: Icon(Icons.settings), text: "Setting"),
                ],
              ),
            ),
          Expanded(child: shell),
        ],
      ),
      bottomNavigationBar: width < 600
          ? NavigationBar(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: (index) {
                shell.goBranch(index);
                if (index == 1) {
                  ref.read(priceListProvider.notifier).getFavouriteList();
                }
              },
              destinations: [
                NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                NavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: "Favourite",
                ),
                NavigationDestination(
                  icon: Icon(Icons.newspaper_outlined),
                  label: "News",
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: "Setting",
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
