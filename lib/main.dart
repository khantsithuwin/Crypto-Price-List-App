import 'dart:ui';

import 'package:crypto_price_list/const/const_route.dart';
import 'package:crypto_price_list/di/locators.dart';
import 'package:crypto_price_list/notifier/app_state/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoRouter.optionURLReflectsImperativeAPIs = true;
  await setupLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  AppStateProvider appStateProvider = AppStateProvider(
    () => AppStateNotifier(),
  );

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton<AppStateProvider>(appStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(appStateProvider).isDark;
    return MaterialApp.router(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
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
