import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

class LikeOnDoubleClick extends StatefulWidget {
  Function f;
  bool contains;
  final FlareControls flareControls;

  LikeOnDoubleClick(this.f, this.contains, this.flareControls, {super.key});

  @override
  _LikeOnDoubleClickState createState() => _LikeOnDoubleClickState();
}

class _LikeOnDoubleClickState extends State<LikeOnDoubleClick> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.f();
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            width: 80,
            height: 80,
            child: FlareActor(
              'assets/fav.flr',
              controller: widget.flareControls,
              animation: 'idle',
            ),
          ),
        ),
      ),
    );
  }
}
