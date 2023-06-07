import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixabay/SearchImage/State/DataManagement.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

Random rand = Random(DateTime.now().millisecond);
var kShimmer = (baseColor: Colors.grey.shade300, highlightColor: Colors.white);

class SkeletonBuilder extends StatelessWidget {
  final Future? f;
  final bool should;
  final Widget Function() child;
  final Widget? skeleton;
  final bool ownShimmer;

   SkeletonBuilder(
      {super.key,
      required this.f,
      required this.should,
      required this.child,
      required this.skeleton,
      this.ownShimmer = false});

  // const SkeletonBuilder(
  //     {super.key,
  //     this.f,
  //     this.should = true,
  //     this.child,
  //     this.skeleton,
  //     this.ownShimmer = false});

  Widget loader() => const Center(
      child:
          SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));


  @override
  Widget build(BuildContext context) {
    if (!should) return child();
    Future<int> fu() async {
      if (f == null) return Future.value(0);
      await f!;
      return 1;
    }

    Widget? skeleton;
    if (this.skeleton != null) {
      skeleton = ownShimmer
          ? this.skeleton
          : Shimmer.fromColors(
              baseColor: kShimmer.baseColor,
              highlightColor: kShimmer.highlightColor,
              child: this.skeleton!);
    }
    return FutureBuilder(
        key: context.read<DataManagement>().key,
        future: fu(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) return child();
          if (!snapshot.hasError) return skeleton ?? loader();
          return Center(child: Text(snapshot.error.toString()));
        });
  }
}
