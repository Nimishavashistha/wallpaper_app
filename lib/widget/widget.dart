import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget BrandName() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(text: 'Wallpaper', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87,fontSize: 16)),
          TextSpan(text: 'Hub', style: TextStyle( color: Colors.blue)),
        ],
      ),
    ),
  );
}

Widget WallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        padding: EdgeInsets.symmetric(horizontal: 16),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: [
          ...wallpapers.map((wallpaper) {
            return GridTile(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ImageView(
                      imgUrl: wallpaper.src.portrait,
                    )
                  ));
                },
                child: Hero(
                  tag: wallpaper.src.portrait,
                  child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(wallpaper.src.portrait,
                        fit: BoxFit.cover,),
                      )),
                ),
              ),
            );
          })
        ]),
  );
}
