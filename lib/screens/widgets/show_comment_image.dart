import 'dart:io';

import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:proste_dialog/proste_dialog.dart';
import 'package:super_tooltip/super_tooltip.dart';

class CommentImage {
  static void showImage({
    required BuildContext context,
    SuperTooltip? tooltip,
    required List<String> imageList,
    required int tapImageId,
  }) {
    DialogTipType _tipType = DialogTipType.success;
    late Animation _animation;
    late AnimationController _animationController;

    showDialog(
      context: context,
      builder: (_) => ProsteCustomDialog(
        insetPadding: EdgeInsets.zero,
        dialogRadius: 5,
        content: ViewImageSlider(
          imageList: imageList,
          index: tapImageId,
        ),
        titlePadding: EdgeInsets.only(top: 0),
        contentPadding: EdgeInsets.only(top: 0),
        showConfirmButton: false,
        showCancelButton: false,
        confirmButtonColor: Colors.cyan,
        cancelButtonColor: Colors.black,
      ),
    );
  }
}

class ViewImageSlider extends StatefulWidget {
  ViewImageSlider({
    required this.imageList,
    this.index = 0,
    Key? key,
  }) : super(key: key);
  final List<String> imageList;
  int index;

  @override
  State<ViewImageSlider> createState() => _ViewImageSliderState();
}

class _ViewImageSliderState extends State<ViewImageSlider> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: 500,
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
              // width: size.width,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: Image.file(
              //       File(widget.imageList[widget.index]),
              //       errorBuilder: (context, exception, stackTrace) {
              //         return Image.network(
              //           widget.imageList[widget.index],
              //           // fit: BoxFit.fill,
              //           errorBuilder: (context, error, stackTrace) {
              //             return Container(
              //               color: Colors.amber,
              //               alignment: Alignment.center,
              //               child: CustomText(text: "Error"),
              //             );
              //           },
              //         );
              //       },
              //     ).image,
              //     fit: BoxFit.fill,
              //   ),
              // ),

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
    );
  }
}
