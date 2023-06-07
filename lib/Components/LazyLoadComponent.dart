import 'package:flutter/material.dart';
import 'package:pixabay/Components/AnimatedListView.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';

extension ListViewRefresh on LazyLoadComponent {
  Widget refresh(Future<void> Function() onRefresh) =>
      RefreshIndicator(onRefresh: onRefresh, child: this);
}

class LazyLoadComponent<T> extends StatefulWidget {
  final Future<void> Function({required int loaded, required int appendCount})
      onListEnd;
  final List<T> children;
  final int initialCount;
  final int appendCount;
  final Widget Function(BuildContext context, int i, bool disabled) builder;
  final List<Widget>? loading;
  final LazyLoadController? controller;

  const LazyLoadComponent(
      {super.key,
      required this.onListEnd,
      required this.children,
      required this.builder,
      required this.appendCount,
      required this.initialCount,
      this.loading,
      this.controller});

  @override
  State<LazyLoadComponent<T>> createState() => _LazyLoadComponentState<T>();
}

class _LazyLoadComponentState<T> extends State<LazyLoadComponent<T>> {
  late LazyLoadController c = widget.controller ??
      LazyLoadController(initialCount: widget.initialCount);
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(onChanged);
  }

  onChanged() {
    if (widget.children.length != c.appendCount) return;
    if (scroll.offset >= scroll.position.maxScrollExtent - 100) {
      if (!c.disabled!) {
        if (mounted) setState(() => c.disabled = true);
        widget
            .onListEnd(
                loaded: widget.children.length, appendCount: widget.appendCount)
            .then((value) {
          if (mounted) setState(() => c.disabled = false);
        });
        c.appendCount += widget.appendCount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: SpaceConstants.paddingMedium.copyWith(top: 0, bottom: 0),
        child: Builder(builder: (context) {
          // return GridView.count(
          //     controller: scroll,
          //     crossAxisCount: 2,
          //     crossAxisSpacing: SpaceConstants.med,
          //     mainAxisSpacing: SpaceConstants.med,
          //     children: [
          //       for (int index = 0; index < widget.children.length + 1; index++)
          //         if (index >= widget.children.length)
          //           ...progressIndicator()
          //         else
          //           widget.builder(context, index, c.disabled)
          //     ]);
          return AnimatedListView(
            ListView(
                controller: scroll,
                children: [
                  for (int index = 0;
                      index < widget.children.length + 1;
                      index++)
                    if (index >= widget.children.length)
                      ...progressIndicator()
                    else
                      widget.builder(context, index, c.disabled)
                ]),
          );
        }));
  }

  List<Widget> progressIndicator() {
    List<Widget> loading =
        widget.loading ?? [const CircularProgressIndicator()];
    return c.disabled ? loading : [];
  }
}

class LazyLoadController {
  late int appendCount;
  late bool disabled;

  LazyLoadController({required int initialCount}) {
    appendCount = initialCount;
    disabled = false;
  }
}
