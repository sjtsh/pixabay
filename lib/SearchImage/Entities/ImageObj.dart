import 'package:hive/hive.dart';

part 'ImageObj.g.dart';

@HiveType(typeId: 0)
class ImageObj {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String owner;
  @HiveField(3)
  final String size;

  ImageObj(this.id, this.url, this.owner, this.size);

  factory ImageObj.dummy(int id) => ImageObj(id, "url", "owner", "size");

  factory ImageObj.parse(Map<String, dynamic> json) => ImageObj(
      json["id"],
      json["previewURL"],
      json["user"],
      ImageSizeConversion.convertSize(json["imageSize"]));

  @override
  bool operator ==(covariant ImageObj other) {
    if (identical(this, other)) return true;
    return other.runtimeType == ImageObj && other.id == id;
  }

  @override
  int get hashCode => Object.hash(id, id);
}

class ImageSizeConversion {
  static String convertSize(int i) {
    var (iB, b) = formalString(i, 1024);
    if (!b) return "$i b";
    var (iK, k) = formalString(iB, 1024);
    if (!k) return "$iB kb";
    var (iM, m) = formalString(iK, 1024);
    if (!m) return "$iM mb";
    var (iG, g) = formalString(iM, 1024);
    if (!g) return "$iG gb";
    return iM.toString();
  }

  static (int, bool) formalString(int i, int divider) {
    bool isGreater = i > divider;
    if (isGreater) i = i ~/ divider;
    return (i, isGreater);
  }
}
