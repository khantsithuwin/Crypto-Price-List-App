import 'package:crypto_price_list/notifier/price_list/price_list_state_notifier.dart';
import 'package:crypto_price_list/widgets/price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({super.key});

  @override
  ConsumerState<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage> {
  final PriceListProvider _provider = GetIt.I.get<PriceListProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).getFavouriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourite")),
      body: PriceLIstWidget(priceListProvider: _provider, isFav: true),
    );
  }
}
