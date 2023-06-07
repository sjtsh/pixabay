import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixabay/SearchImage/Entities/ImageObj.dart';
import 'package:provider/provider.dart';

import 'DataManagement.dart';

class FavouritesManagement with ChangeNotifier {
  Set<ImageObj> favourites = {};

  void act(ImageObj id) {
    if (favourites.contains(id)) {
      favourites.remove(id);
    } else {
      favourites.add(id);
    }
    notifyListeners();
    HiveService.put(favourites);
  }

  bool contains(ImageObj id) => favourites.contains(id);
}

class HiveService {
  static late Box box;

  static initHive(BuildContext context) async {
    FavouritesManagement read = context.read<FavouritesManagement>();
    DataManagement readData = context.read<DataManagement>();
    (Set<ImageObj>, String) results = await initAdapters();
    read.favourites = results.$1;
    readData.searchController.text = results.$2;
    readData.refresh();
  }

  static put(Set<ImageObj> favourites) async {
    await box.put("fav", favourites.toList());
  }

  static Future<(Set<ImageObj>, String)> initAdapters() async {
    Hive
      ..init((await getApplicationDocumentsDirectory()).path)
      ..registerAdapter(ImageObjAdapter());
    box = await Hive.openBox('myBox');
    Set<ImageObj> returnable = {};
    for (var i in (box.get("fav") ?? [])) {
      returnable.add(i);
    }
    (Set<ImageObj>, String) finallyParsed =
        (returnable, (box.get("searched") ?? ""));
    return finallyParsed;
  }

  static putText(String text) async {
    await box.put("searched", text);
  }
}
