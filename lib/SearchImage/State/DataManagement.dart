import 'package:flutter/cupertino.dart';
import 'package:pixabay/SearchImage/State/FavouritesManagement.dart';
import 'package:provider/provider.dart';

import '../../Components/LazyLoadComponent.dart';
import '../../Pre/withProvider.dart';
import '../../Services/ImageService.dart';
import '../Entities/ImageObj.dart';

class DataManagement with ChangeNotifier {
  List<ImageObj> images = [];
  LazyLoadController lazyController = LazyLoadController(initialCount: 10);
  UniqueKey key = UniqueKey();

  TextEditingController searchController = TextEditingController();
  Future myFuture = Future.delayed(const Duration(seconds: 10));

  Future<dynamic> Function() homeFunction(BuildContext context,
          {String? text}) =>
      () async => ImageService().getImages(text ?? "", 1).then((value) {
            print(images.length);
            return context.read<DataManagement>().images = value;
          });

  Future<dynamic> Function() appendPage(BuildContext context, int page) =>
      () async => ImageService()
              .getImages(searchController.text, page + 1)
              .then((value) {
            context.read<DataManagement>().images.addAll(value);
            notifyListeners();
            return 1;
          });

  refresh() async {
    HiveService.putText(searchController.text);
    myFuture = ctx
        .read<DataManagement>()
        .homeFunction(ctx, text: searchController.text)();
    key = UniqueKey();
    lazyController.appendCount = 10;
    await myFuture;
    notifyListeners();
  }
}
