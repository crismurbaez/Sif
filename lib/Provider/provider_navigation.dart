import 'package:flutter/material.dart';
import 'package:sif/Model/route.dart';

class ProviderNavigation extends ChangeNotifier {
  ItemRoute _itemRoute = ItemRoute.home;

  ItemRoute get itemRoute => _itemRoute;

  void setItemRoute(ItemRoute itemRoute) {
    _itemRoute = itemRoute;

    notifyListeners();
  }
}
