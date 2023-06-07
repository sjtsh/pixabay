import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/Components/CommonDialog.dart';
import 'package:pixabay/Constants.dart';
import 'package:pixabay/SearchImage/State/FavouritesManagement.dart';
import 'package:pixabay/Services/StaticService.dart';
import 'package:provider/provider.dart';

import '../../Components/LikeOnDoubleClick.dart';
import '../../Pre/withProvider.dart';
import '../Entities/ImageObj.dart';

class SingularFeedImage extends StatelessWidget {
  final ImageObj image;

  SingularFeedImage(this.image, {super.key});

  final FlareControls flareControls = FlareControls();

  fav(BuildContext context) {
    FavouritesManagement read = context.read<FavouritesManagement>();
    if (read.contains(image)) {
      showDialog(
          context: context,
          builder: (_) => CommonDialog(
              title: "Are you sure?",
              subtitle: "The image will be removed from your favourites list",
              onConfirmed: () {
                read.act(image);
                Navigator.pop(context);
              }));
    } else {
      flareControls.play("like");
      read.act(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
              child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child:
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Positioned.fill(
                      child: StaticService.cache(image.url, constraints)),
                  LikeOnDoubleClick(
                      key: UniqueKey(),
                      () => fav(context),
                      context.read<FavouritesManagement>().contains(image),
                      flareControls)
                ],
              );
            }),
          )),
          Row(
            children: [
              SpaceConstants.space,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    image.owner,
                    maxLines: 1,
                  ),
                  Text(
                    image.size,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              )),
              SpaceConstants.space,
              IconButton(
                  onPressed: () => fav(context),
                  icon: context
                          .watch<FavouritesManagement>()
                          .favourites
                          .contains(image)
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border))
            ],
          )
        ],
      ),
    );
  }
}
