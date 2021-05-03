import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;

  const Categorie({Key key, this.categorieName}) : super(key: key);

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      //element is having all the keys inside "photos" key.
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }


  @override
  void initState() {
   getSearchWallpapers(widget.categorieName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16,),

              WallpapersList(wallpapers: wallpapers, context: context),
            ],

          ),
        ),
      ),
    );
  }
}
