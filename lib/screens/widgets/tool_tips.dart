import 'package:info_with_comments/controllers/comment_controller.dart';
import 'package:info_with_comments/controllers/manage_comment.dart';
import 'package:info_with_comments/dtos/commnet_liks.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:ndialog/ndialog.dart';

class MyToolTips {
  static void showLiksCount({
    required BuildContext context,
    SuperTooltip? tooltip,
    required List<CommentLike> list,
  }) {
    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;
    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);
    tooltip = SuperTooltip(
      maxWidth: 200,
      maxHeight: 90,
      arrowTipDistance: 0.0,
      arrowBaseWidth: 0.0,
      arrowLength: 0.0,
      shadowColor: kBlack.withOpacity(0.1),
      borderColor: kTransparent,
      popupDirection: TooltipDirection.up,
      content: Scaffold(
        body: Container(
          width: 200,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int x = 0; x < list.length; x++)
                if (list[x].emojiCount > 0)
                  Column(
                    children: [
                      CustomText(
                        text: list[x].emoji,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: list[x].emojiCount > 1000
                            ? '${(list[x].emojiCount / 1000).toStringAsFixed(2)}K'
                            : '${list[x].emojiCount}',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  )
            ],
          ),
        ),
      ),
    );
    tooltip.show(context);
  }

  static Future<void> likeSelect({
    required BuildContext context,
    required List<CommentLike> emojies,
    required int mainId,
    int subCommentId=-1,
    required ManageComment commentController,
    required bool isReply,
    required String userId,
  }) async {
   final dilog = await NDialog(
      dialogStyle: DialogStyle(
        titleDivider: true,
      ),
      content: Container(
        width: 50,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int x = 0; x < 1; x++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int x = 0; x < 3; x++)
                    InkWell(
                      onTap: (){

                        if(isReply){
                          commentController.likeForSubComment(likeTypeId: x, likeType: emojies[x].emoji, mainCommentId: mainId, userId: userId,subCommentID: subCommentId);
                        }else{
                          commentController.likeForMainComment(likeTypeId: x, likeType: emojies[x].emoji, mainCommentId: mainId, userId: userId);
                        }

                        Navigator.pop(context);
                      },
                      child: CustomText(
                        text: emojies[x].emoji,
                        fontSize: 40,
                      ),
                    ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int x = 3; x < emojies.length; x++)
                  InkWell(
                    onTap: (){
                      if(isReply){
                        commentController.likeForSubComment(likeTypeId: x, likeType: emojies[x].emoji, mainCommentId: mainId, userId: userId,subCommentID: subCommentId);

                      }else{
                        commentController.likeForMainComment(likeTypeId: x, likeType: emojies[x].emoji, mainCommentId: mainId,userId:userId );
                      }
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CustomText(
                        text: emojies[x].emoji,
                        fontSize: 40,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    ).show(context);
  }
}
