import 'package:crypto_price_list/pages/price_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    GoRouterState state = GoRouter.of(context).state;
    String path = state.uri.path;
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          if (width >= 600)
            DefaultTabController(
              length: 4,
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.favorite), text: "Favourite"),
                  Tab(icon: Icon(Icons.newspaper_outlined), text: "News"),
                  Tab(icon: Icon(Icons.settings), text: "Setting"),
                ],
              ),
            ),
          if (path == "/list") PriceListPage(),
        ],
      ),
      bottomNavigationBar: width < 600
          ? NavigationBar(
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
