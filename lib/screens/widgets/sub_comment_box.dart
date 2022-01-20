import 'dart:ui';

import 'package:info_with_comments/controllers/manage_comment.dart';
import 'package:info_with_comments/dtos/sub_comment_dto.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/screens/widgets/tab_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCommentDisplayBox extends StatelessWidget {
  const SubCommentDisplayBox({
    required this.comment,
    required this.manageComment,
    Key? key,
  }) : super(key: key);

  final SubCommentDTO comment;
  final ManageComment manageComment;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 8, left: 15, bottom: 8, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: manageComment.subCommentBoxColor.withOpacity(0.1),
        boxShadow: [
          if (manageComment.subBoxshowBoxShadow)
            BoxShadow(
              color: manageComment.subCommentBoxColor.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1, 3), // changes position of shadow
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: comment.commentedBy,
                  fontWeight: manageComment.subUserNameFontWeight,
                  fontSize: manageComment.subCommentUserNameFontSize,
                ),
                CustomText(
                  text: comment.getMainCommentTime(),
                  fontWeight: manageComment.subUserNameFontWeight,
                  fontSize: manageComment.tagToFontSize,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              // text: 'Hello ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                if (comment.tagTo != null)
                  TextSpan(
                    text: '${comment.tagTo} ',
                    style: TextStyle(
                      fontWeight: manageComment.tagToWeight,
                      fontSize: manageComment.tagToFontSize,
                    ),
                  ),
                TextSpan(text: '${comment.comment}'),
              ],
            ),
          ),
          if (!comment.commentImgUrl.isEmpty &&
              comment.commentImgUrl.length == 1)
            SizedBox(
              height: 10,
            ),
          if (!comment.commentImgUrl.isEmpty &&
              comment.commentImgUrl.length == 1)
            Container(child: TapImage(index: 0, comment: comment)),
          if (!comment.commentImgUrl.isEmpty &&
              comment.commentImgUrl.length == 1)
            SizedBox(
              height: 10,
            ),
          if (!comment.commentImgUrl.isEmpty &&
              comment.commentImgUrl.length > 1)
            SizedBox(
              height: 10,
            ),
          if (!comment.commentImgUrl.isEmpty &&
              comment.commentImgUrl.length > 1)
            Container(
              width: size.width,
              height: comment.commentImgUrl.length > 3 ? 300 : 150,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: comment.commentImgUrl.length == 2
                    ? 2
                    : comment.commentImgUrl.length == 3
                        ? 2
                        : comment.commentImgUrl.length >= 4
                            ? 4
                            : comment.commentImgUrl.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    height: 50,
                    width: size.width,
                    color: comment.commentImgUrl.length == 3
                        ? index == 2
                            ? Colors.amber
                            : Colors.black87.withOpacity(0.5)
                        : Colors.red,
                    child: TapImage(
                      comment: comment,
                      index: index,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
