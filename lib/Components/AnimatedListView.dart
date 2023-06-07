import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/Constants.dart';
import 'package:shimmer/shimmer.dart';

enum OTAnimations {
  home,
  favourites;

  static Set<String> ot = {};

  bool invoke() => ot.contains(name);

  bool invokeOT() {
    bool returnable = ot.contains(name);
    navigate(name);
    return returnable;
  }

  static navigate(String screen) => ot.add(screen);
}

extension Animate on ListView {
  Widget animate(OTAnimations ot) =>
      ot.invoke() ? this : AnimatedListView(this);

  Widget animateOT(OTAnimations ot) =>
      ot.invokeOT() ? this : AnimatedListView(this);
}

class AnimatedListView extends StatefulWidget {
  ListView listView;

  AnimatedListView(this.listView, {super.key});

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    int len = (widget.listView.childrenDelegate as SliverChildListDelegate)
        .children
        .length;
    _animationController = start(len > 6 ? 1000 : ((1000 * len) / 4).round());
  }

  AnimationController start(int time) {
    AnimationController controller = AnimationController(
      duration: Duration(milliseconds: time),
      vsync: this,
    );
    controller.forward();
    return controller;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children =
        (widget.listView.childrenDelegate as SliverChildListDelegate).children;
    return ListView(
      scrollDirection: widget.listView.scrollDirection,
      controller: widget.listView.controller,
      clipBehavior: widget.listView.clipBehavior,
      padding: widget.listView.padding,
      physics: widget.listView.physics,
      addAutomaticKeepAlives:
          (widget.listView.childrenDelegate as SliverChildListDelegate)
              .addAutomaticKeepAlives,
      addRepaintBoundaries:
          (widget.listView.childrenDelegate as SliverChildListDelegate)
              .addRepaintBoundaries,
      addSemanticIndexes:
          (widget.listView.childrenDelegate as SliverChildListDelegate)
              .addSemanticIndexes,
      cacheExtent: widget.listView.cacheExtent,
      dragStartBehavior: widget.listView.dragStartBehavior,
      itemExtent: widget.listView.itemExtent,
      keyboardDismissBehavior: widget.listView.keyboardDismissBehavior,
      key: widget.listView.key,
      primary: widget.listView.primary,
      prototypeItem: widget.listView.prototypeItem,
      restorationId: widget.listView.restorationId,
      reverse: widget.listView.reverse,
      semanticChildCount: widget.listView.semanticChildCount,
      shrinkWrap: widget.listView.shrinkWrap,
      children: [
        for (int i = 0; i < children.length; i += 2) ...[
          SizedBox(
            height: 200,
            child: Row(
              children: [
                buildItem(children, i, _animationController),
                SpaceConstants.space,
                buildItem(children, i + 1, _animationController),
              ],
            ),
          ),
          SpaceConstants.space,
        ]
      ],
    );
  }

  Widget buildItem(List<Widget> children, int index,
      AnimationController controller) {
    if (index >= children.length) return Expanded(child: Container());
    if (children[index] is Shimmer) return Expanded(child: children[index]);
    return Expanded(
      child: AnimatedListItem(
        index: index,
        length: children.length,
        aniController: controller,
        animationType: AnimationType.zoomIn,
        startX: 40,
        startY: 40,
        child: children[index],
      ),
    );
  }

}
