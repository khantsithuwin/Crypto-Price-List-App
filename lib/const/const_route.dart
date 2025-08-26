import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/favourite_page.dart';
import '../pages/home_page.dart';
import '../pages/news_page.dart';
import '../pages/price_list_detail_page.dart';
import '../pages/price_list_page.dart';
import '../pages/setting_page.dart';

const List<String> mainRoutes = ['/', '/favourite', '/news', '/setting'];

final GoRouter route = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "list",
              path: "/",
              builder: (context, state) {
                return PriceListPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "favourite",
              path: "/favourite",
              builder: (context, state) {
                return FavouritePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "news",
              path: "/news",
              builder: (context, state) {
                return NewsPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: "setting",
              path: "/setting",
              builder: (context, state) {
                return SettingPage();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: "details",
      path: "/details",
      builder: (context, state) {
        String? symbol = state.uri.queryParameters['symbol'];
        String? name = state.uri.queryParameters['name'];
        if (symbol != null && name != null) {
          return PriceListDetailPage(symbol: symbol, name: name);
        } else {
          return SizedBox.shrink();
        }
      },
    ),
  ],
);
