import 'dart:io';

import 'package:info_with_comments/controllers/manage_comment.dart';
import 'package:info_with_comments/screens/widgets/comment_input.dart';
import 'package:info_with_comments/screens/widgets/custom_rounded_button.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageComment extends StatefulWidget {
   ViewImageComment({
    Key? key,
    required this.imageList,
    required this.commentController,
    required this.userId,
  }) : super(key: key);
   final List<Media> imageList;
   final ManageComment commentController;
    String userId;

  @override
  _ViewImageCommentState createState() => _ViewImageCommentState();

   @override
   void dispose() {
     // TODO: implement dispose
     // super.di
     print('Fuck');
  }
}



class _ViewImageCommentState extends State<ViewImageComment> {
  int index2 = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kBlack.withOpacity(0.9),
          width: size.width,
          height: size.height,
          // color: kGreen,
          child: Column(
            children: [
              Container(
                height: 40,
                width: size.width,
                // color: kBlack,
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_sharp,
                          size: 30,
                          color: kWhite,
                        ),
                      ),
                      padding: EdgeInsets.only(left: 15),
                    )
                  ],
                ),
              ),
              if (widget.imageList.isEmpty)
                Expanded(
                  child: Container(
                    child: Icon(
                      Icons.image_not_supported_sharp,
                      color: kWhite,
                      size: 100,
                    ),
                  ),
                ),
              if (!widget.imageList.isEmpty)
                Expanded(
                  child: Stack(
                    children: [
                      if(widget.imageList.length>0)
                      Container(
                        alignment: Alignment.center,
                        child: FileImage(widget: widget,index: index2,),
                      ),
                      if (widget.imageList.length == 1)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            child: Icon(
                              Icons.cancel,
                              color: kWhite,
                            ),
                            onTap: () {
                              setState(
                                () {
                                  widget.imageList.removeAt(index2);
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              if (widget.imageList.length != 1)
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        height: 80,
                        width: 120,
                        // color: kBlack,
                        child: Stack(
                          children: [
                            InkWell(
                              child: Container(
                                height: 80,
                                width: 120,
                                child:FileImage(widget: widget,index: i,),
                              ),
                              onTap: () {
                                setState(
                                  () {
                                    index2 = i;
                                  },
                                );
                              },
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                child: Icon(
                                  Icons.cancel,
                                  color: kWhite,
                                ),
                                onTap: () {
                                  setState(
                                    () {
                                      index2 =
                                          widget.imageList.length == 1 ? 0 : 0;
                                          widget.imageList.removeAt(1);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              Container(
                width: size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kWhite,
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: kBlack.withOpacity(0.5),
                    ),
                  ),
                ),
                // height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: CommentInput(
                        controller: widget.commentController.textController,
                        showImage: false,
                        loadImage: () async {},
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomRoundButton(
                      onTap: () {
                        setState(() {
                          if( widget.imageList.length==0){
                            return;
                          }else{
                            Navigator.pop(context);
                            widget.commentController.imageComment( userId: widget.userId,list:  widget.imageList);
                          }
                        });


                        // });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FileImage extends StatelessWidget {
  const FileImage({
    Key? key,
    required this.widget, required this.index,

  }) : super(key: key);

  final ViewImageComment widget;
  final int index ;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      tightMode: true,
      imageProvider: Image.file(
        File(widget.commentController.getImageUril(index ,widget.imageList,)),
        fit: BoxFit.fitHeight,
        errorBuilder: (context,error,stackTrace ){
          return CustomText(text: "text");
        },
      ).image,
    );

  }
}
