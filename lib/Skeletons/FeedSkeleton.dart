import 'package:flutter/material.dart';
import 'package:pixabay/SearchImage/State/DataManagement.dart';
import 'package:pixabay/SearchImage/UI/SearchImage.dart';
import 'package:pixabay/Services/ImageService.dart';
import 'package:pixabay/Skeletons/SingularFeedImageSkeleton.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Components/LazyLoadComponent.dart';
import '../Components/LikeOnDoubleClick.dart';
import '../Components/SkeletonBuilder.dart';
import '../Constants.dart';
import '../Pre/withProvider.dart';
import '../SearchImage/Entities/ImageObj.dart';
import '../SearchImage/UI/FeedScreen.dart';
import '../SearchImage/UI/SingularFeedImage.dart';

class FeedWithSkeleton extends StatefulWidget {
  @override
  State<FeedWithSkeleton> createState() => _FeedWithSkeletonState();
}

class _FeedWithSkeletonState extends State<FeedWithSkeleton> {

  @override
  Widget build(BuildContext context) {
    return SkeletonBuilder(
        f: context.watch<DataManagement>().myFuture,
        skeleton: Padding(
            padding: SpaceConstants.paddingMedium.copyWith(top: 0, bottom: 0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: SpaceConstants.med,
              mainAxisSpacing: SpaceConstants.med,
              children: [
                ...List.generate(10, (index) => ImageObj.dummy(index))
                    .map((e) => const SingularFeedImageSkeleton())
              ],
            )),
        should: true,
        child: () => Builder(
          builder: (context) {
            if(context.watch<DataManagement>().images.isEmpty) return const Center(child: Text("No search results"),);
            return LazyLoadComponent<ImageObj>(
                  controller: context.watch<DataManagement>().lazyController,
                  onListEnd: (
                      {required int appendCount, required int loaded}) async {
                    await context
                        .read<DataManagement>()
                        .appendPage(context, loaded ~/ 10)();
                  },
                  loading: List.generate(4, (index) => ImageObj.dummy(index))
                      .map((e) => Shimmer.fromColors(
                          baseColor: kShimmer.baseColor,
                          highlightColor: kShimmer.highlightColor,
                          child: const SingularFeedImageSkeleton()))
                      .toList(),
                  children: context.watch<DataManagement>().images,
                  builder: (BuildContext ctx, int i, bool disabled) =>
                      SingularFeedImage(context.watch<DataManagement>().images[i]),
                  appendCount: 10,
                  initialCount: 10,
                ).refresh(() => context.read<DataManagement>().refresh());
          }
        ));
  }
}
