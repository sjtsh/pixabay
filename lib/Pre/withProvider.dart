import 'package:flutter/material.dart';
import 'package:pixabay/Pre/withTheme.dart';
import 'package:pixabay/SearchImage/State/FavouritesManagement.dart';
import 'package:provider/provider.dart';

import '../SearchImage/State/DataManagement.dart';

late BuildContext ctx;

class WithProvider extends StatelessWidget {
  final Widget child;

  const WithProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataManagement()),
        ChangeNotifierProvider(create: (_) => FavouritesManagement()),
      ],
      child:child
    );
  }
}

class WithMaterial extends StatelessWidget {
  final Widget child;

  const WithMaterial({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixabay',
        theme: ThemeService.light(context),
        home:  Builder(builder: (context1) {
          ctx = context1;
          return child;
        }),);
  }
}
