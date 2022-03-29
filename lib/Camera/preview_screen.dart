import 'dart:io';

import 'package:basic_sqflite/DB/catImage_handler.dart';
import 'package:basic_sqflite/Model/image.dart';
import 'package:basic_sqflite/Model/utility.dart';
import 'package:basic_sqflite/Screen/catTime_screen.dart';
import 'package:flutter/material.dart';

import '../Camera/captures_screen.dart';

class PreviewScreen extends StatefulWidget {
  final int idPro;
  final int idTime;
  final File imageFile;
  final List<File> fileList;
  const PreviewScreen({
    Key? key,
    required this.idPro,
    required this.idTime,
    required this.imageFile,
    required this.fileList,
  }) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  CatImageHelper ImageHelper = CatImageHelper();
  late List<ImageModel> images;

  @override
  void initState() {
    // TODO: implement initState
    ImageHelper = CatImageHelper();
    refreshImages();
    super.initState();
  }

  refreshImages() {
    ImageHelper.getCatTimePhotos(widget.idTime).then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview"), actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CapturesScreen(
                        idPro: widget.idPro,
                        idTime: widget.idTime,
                        imageFileList: widget.fileList,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.photo)),
            IconButton(
                onPressed: () async {
                  final file = widget.imageFile;
                  String imgString =
                      Utility.base64String(file.readAsBytesSync());
                  ImageModel photo = ImageModel(
                      idPro: widget.idPro,
                      idTime: widget.idTime,
                      imagePath: imgString);

                  await ImageHelper.save(photo);
                  refreshImages();

                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) => CatTimeScreen(catProId: widget.idPro,)),
                  //     (Route<dynamic> route) => false);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.save))
          ],
        )
      ]),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextButton(
          //     onPressed: () {},
          //     child: Text('Go to all captures'),
          //     style: TextButton.styleFrom(
          //       primary: Colors.black,
          //       backgroundColor: Colors.white,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Image.file(widget.imageFile),
          ),
        ],
      ),
    );
  }
}
