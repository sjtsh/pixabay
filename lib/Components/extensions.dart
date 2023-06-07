
import 'package:flutter/material.dart';

extension TextSkeleton on TextStyle {
  Widget skeleton(int i) => SizedBox(
    height: fontSize,
    width: i * 10,
    child: Center(
      child: Container(
          height: fontSize == null ? 7.0 : (fontSize! / 2),
          width: i * 10,
          color: Colors.white),
    ),
  );
}
