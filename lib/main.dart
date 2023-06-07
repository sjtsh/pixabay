import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixabay/Pre/withProvider.dart';
import 'package:pixabay/SearchImage/State/DataManagement.dart';
import 'package:provider/provider.dart';

import 'Pre/withTheme.dart';
import 'SearchImage/Entities/ImageObj.dart';
import 'SearchImage/State/FavouritesManagement.dart';
import 'SearchImage/UI/SearchImage.dart';

void main() {
  // runApp(const MyApp());
  runApp(const WithProvider(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    HiveService.initHive(context);
  }

  @override
  Widget build(BuildContext context) {
    return const WithMaterial(child: SearchImage());
  }
}
