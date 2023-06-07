import 'package:flutter/material.dart';
import 'package:pixabay/Components/extensions.dart';

import '../Components/SkeletonBuilder.dart';
import '../Constants.dart';

class SingularFeedImageSkeleton extends StatelessWidget {
  const SingularFeedImageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(12)),
              )),
          Row(
            children: [
              SpaceConstants.space,
              theme.displayMedium!
                                .copyWith(fontWeight: FontWeight.bold)
                                .skeleton(rand.nextInt(5) + 5),
              Expanded(child: Container()),
              SpaceConstants.space,
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.favorite_border))
            ],
          )
        ],
      ),
    );
    // Column(
    //   children: [
    //     SpacePalette.spaceMedium,
    //     Row(
    //       children: [
    //         const Icon(Icons.person, size: 56),
    //         SpacePalette.spaceSmall,
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               theme.displayLarge!
    //                   .copyWith(fontWeight: FontWeight.bold)
    //                   .skeleton(rand.nextInt(5) + 5),
    //               SpacePalette.spaceTiny,
    //               theme.displayMedium!
    //                   .copyWith(color: Colors.white)
    //                   .skeleton(rand.nextInt(2) + 1),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     SpacePalette.spaceMedium,
    //     Container(
    //       width: double.infinity,
    //       height: 2,
    //       color: Colors.white.withOpacity(0.7),
    //     )
    //   ],
    // );
  }
}

class ImageSkeleton extends StatelessWidget {
  const ImageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12)),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
    ),
  );
  }
}
