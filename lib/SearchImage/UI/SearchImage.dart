import 'package:flutter/material.dart';
import 'package:pixabay/SearchImage/State/DataManagement.dart';
import 'package:pixabay/SearchImage/UI/FeedScreen.dart';
import 'package:pixabay/Skeletons/FeedSkeleton.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Favourites/UI/FavouritesScreen.dart';
import '../Entities/ImageObj.dart';
import 'SingularFeedImage.dart';

class SearchImage extends StatelessWidget {
  const SearchImage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text("Search Image"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FavouritesScreen(
                                context,
                              ))),
                  icon: const Icon(Icons.favorite))
            ],
          ),
          Padding(
            padding: SpaceConstants.paddingMedium.copyWith(bottom: 0),
            child: TextField(
              controller: context.read<DataManagement>().searchController,
              onSubmitted: (_)=> context.read<DataManagement>().refresh(),
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: context.read<DataManagement>().refresh,
                  )),
            ),
          ),
          Expanded(child: FeedWithSkeleton())
        ],
      ),
    );
  }
}
