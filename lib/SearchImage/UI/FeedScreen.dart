import 'package:flutter/material.dart';
import 'package:pixabay/Components/AnimatedListView.dart';
import 'package:pixabay/Constants.dart';
import 'package:pixabay/SearchImage/Entities/ImageObj.dart';
import 'package:pixabay/SearchImage/UI/SingularFeedImage.dart';

class FeedScreen extends StatelessWidget {
  final List<Widget> images;
  final Future<void> Function() onRefresh;

  const FeedScreen(this.images, this.onRefresh, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: SpaceConstants.paddingMedium.copyWith(top: 0, bottom: 0),
        child: AnimatedListView(
           ListView(
            children: images,
          ),
        ));
  }
}
