import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class ImageView extends StatefulWidget {
  final String imgUrl;

  const ImageView({Key key, @required this.imgUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          _save();
        },
        child: Stack(

          children: [
            Hero(
              tag: widget.imgUrl,
              child: Container(
                height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(widget.imgUrl,fit: BoxFit.cover,)),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 Stack(
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width/2,
                       height: 50,
                       decoration: BoxDecoration(
                         color: Color(0xff1C1B1B).withOpacity(0.8),
                         borderRadius: BorderRadius.circular(40),
                       ),
                     ),
                     Container(
                       height: 50,
                       alignment: Alignment.center,
                       width: MediaQuery.of(context).size.width/2,
                       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.white24,
                               width: 1),
                           borderRadius: BorderRadius.circular(40),
                           gradient: LinearGradient(
                               colors:[
                                 Color(0x36FFFFFF),
                                 Color(0x0FFFFFFF),
                               ],
                               begin: FractionalOffset.topLeft,
                               end: FractionalOffset.bottomRight,
                           )
                       ),
                       child: Column(
                         children: [
                           Text("Set Wallpaper",
                             style: TextStyle(
                               fontSize: 15,
                               color: Colors.white70,
                               fontWeight: FontWeight.w500,
                             ),),
                           SizedBox(height: 1,),
                           Text("Image will be saved in gallery",
                             style: TextStyle(
                               fontSize: 10,
                               color: Colors.white70,
                             ),)
                         ],
                       ),
                     ),
                   ],
                 ),
                  SizedBox(height: 16,),
                  Text("Cancel",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  SizedBox(height: 50,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
//    if (Platform.isISO) {
//      /*Map<PermissionGroup, PermissionStatus> permissions =
//          */await PermissionHandler()
//          .requestPermissions([PermissionGroup.photos]);
//    } else {
//      /* PermissionStatus permission = */await PermissionHandler()
//          .checkPermissionStatus(PermissionGroup.storage);
//    }
  }
}
