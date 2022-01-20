import 'package:info_with_comments/controllers/comment_controller.dart';
import 'package:info_with_comments/controllers/manage_comment.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/screens/widgets/tool_tips.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class LikeReply extends StatefulWidget {
  const LikeReply({
    required this.likeOnTap,
    required this.replyOnTap,
    required this.mainCommentId,
    required this.isReply,
    required this.commentController,
    this.subCommentId = -1,
    required this.userId,
    Key? key,
  }) : super(key: key);

  final Function() likeOnTap;
  final Function() replyOnTap;
  final ManageComment commentController;
  final bool isReply;
  final int mainCommentId;
  final int subCommentId;
  final String userId;

  @override
  State<LikeReply> createState() => _LikeReplyState();
}

class _LikeReplyState extends State<LikeReply> {
  SuperTooltip? tooltip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      margin: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              MyToolTips.likeSelect(
                context: context,
                emojies: widget.commentController.getEmojiesForLike(),
                mainId: widget.mainCommentId,
                subCommentId: widget.subCommentId,
                commentController: widget.commentController,
                isReply: widget.isReply,
                userId: widget.userId,
              );
              widget.likeOnTap;
            },
            child: CustomText(
              text: "Like",
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: widget.replyOnTap,
            child: CustomText(
              text: "Reply",
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
