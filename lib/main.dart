import 'dart:ui';

import 'package:crypto_price_list/const/const_route.dart';
import 'package:crypto_price_list/di/locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await setupLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: route,
    );
  }
}
