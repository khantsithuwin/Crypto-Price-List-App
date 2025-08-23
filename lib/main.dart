import 'package:crypto_price_list/pages/home_page.dart';
import 'package:crypto_price_list/pages/price_list_detail_page.dart';
import 'package:crypto_price_list/pages/price_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

void main() {
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            name: "home",
            path: "/",
            builder: (context, state) {
              return HomePage();
            },
          ),
          GoRoute(
            name: "list",
            path: "/list",
            builder: (context, state) {
              return PriceListPage();
            },
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
          GoRoute(
            name: "favourite",
            path: "/favourite",
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
          GoRoute(
            name: "news",
            path: "/news",
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
          GoRoute(
            name: "setting",
            path: "/setting",
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
      ),
    );
  }
}
