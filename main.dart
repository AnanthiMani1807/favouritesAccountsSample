import 'package:favourites_sample/presentation/account_widget.dart';
import 'package:favourites_sample/presentation/favourite_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourites_sample/service/account_service.dart' as account_service;

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer(
        builder: (context, ref, _) {
          final selectedMenu = ref.watch(account_service.accountCategoryProvider);
          if (selectedMenu == 'Account') {
            return AccountWidget();
          } else if (selectedMenu == 'Favourites'){
            return FavouriteWidget();
          }else{
            return FavouriteWidget();
          }
        },
      ),
    );
  }
}
