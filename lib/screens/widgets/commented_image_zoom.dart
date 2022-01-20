import 'dart:io';

import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CommentedImageZoomView extends StatefulWidget {
  CommentedImageZoomView({Key? key, required this.imageList, this.index = 0})
      : super(key: key);

  final List<String> imageList;
  int index;

  @override
  _CommentedImageZoomViewState createState() => _CommentedImageZoomViewState();
}

class _CommentedImageZoomViewState extends State<CommentedImageZoomView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              // color: kBlack,
              child: PageView.builder(
                onPageChanged: (page) {
                  setState(() {
                    widget.index = page;
                  });
                },
                itemCount: widget.imageList.length,
                physics: BouncingScrollPhysics(),
                pageSnapping: true,
                itemBuilder: (context, i) {
                  return Container(
                    height: 500,
                    child: PhotoView(
                      tightMode: true,
                      imageProvider: Image.file(
                        File(widget.imageList[widget.index]),
                      ).image,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  size: 30,
                  color: kWhite.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
