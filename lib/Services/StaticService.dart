import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Pre/withProvider.dart';

class StaticService {
  static Widget cache(String url, BoxConstraints constraints, {BoxFit? fit}) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url,
      progressIndicatorBuilder: (_, __, DownloadProgress progress) => Container(
        color: const Color(0xfff2f2f2),
        child: Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: progress.progress,
                  color: Theme.of(ctx).primaryColor,
                ))),
      ),
      errorWidget: (_, __, ___) => Text(___.toString()),
    );
  }
}
