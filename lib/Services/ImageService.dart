import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixabay/SearchImage/Entities/ImageObj.dart';

class ImageService {
  static String apiKey = "37095143-75f17f19eb10d33f786b56b23";

  Future<List<ImageObj>> getImages(String searchText, int page) async {
    Response response = await get(Uri.parse(addQueries({
      "q": searchText.replaceAll(" ", "+"),
      "page": page.toString(),
      "per_page": "10"
    }, "https://pixabay.com/api")), );
    List<dynamic> parsable = jsonDecode(response.body)["hits"];
    return parsable.map((e) => ImageObj.parse(e)).toList();
  }

  Future<ImageObj> getImageById(String id) async {
    Response response = await get(
        Uri.parse(addQueries({"id": id}, "https://pixabay.com/api/")));
    return ImageObj.parse(jsonDecode(response.body));
  }

  String addQueries(Map<String, String> params, String url) {
    params["key"] = apiKey;
    url += "?";
    int counter = 0;
    for (var i in params.entries) {
      if (counter != 0) url += "&";
      url += "${i.key}=${i.value}";
      counter++;
    }
    return url;
  }
}
