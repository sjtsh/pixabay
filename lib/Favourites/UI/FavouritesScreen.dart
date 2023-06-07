import 'package:flutter/material.dart';
import 'package:pixabay/Pre/withProvider.dart';
import 'package:pixabay/SearchImage/State/FavouritesManagement.dart';
import 'package:pixabay/SearchImage/UI/FeedScreen.dart';
import 'package:pixabay/SearchImage/UI/SingularFeedImage.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Favourites/UI/FavouritesScreen.dart';

class FavouritesScreen extends StatelessWidget {
  final BuildContext ctx;

  FavouritesScreen(this.ctx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
              title: const Text("Favourites"),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios))),
          Expanded(
              child: ctx.watch<FavouritesManagement>().favourites.isEmpty
                  ? const Center(child: Text("No favourites yet"))
                  : FeedScreen(
                      ctx
                          .watch<FavouritesManagement>()
                          .favourites
                          .toList()
                          .map((e) => SingularFeedImage(e))
                          .toList(),
                      () async {}))
        ],
      ),
    );
  }
}
