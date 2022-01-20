library info_with_comments;

import 'package:info_with_comments/controllers/manage_comment.dart';
import 'package:info_with_comments/screens/widgets/comment_display_box.dart';
import 'package:info_with_comments/screens/widgets/comment_input.dart';
import 'package:info_with_comments/screens/widgets/comment_liks.dart';
import 'package:info_with_comments/screens/widgets/commenter_image.dart';
import 'package:info_with_comments/screens/widgets/custom_rounded_button.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/screens/widgets/like_reply.dart';
import 'package:info_with_comments/screens/widgets/manage_image_comments.dart';
import 'package:info_with_comments/screens/widgets/sub_comment_box.dart';
import 'package:info_with_comments/screens/widgets/tool_tips.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:info_with_comments/utils/manage_image_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_tooltip/super_tooltip.dart';


class MessageView extends StatefulWidget {
  MessageView({
    Key? key,
    this.childWidget,
    required this.currentUserId,
    required this.commentController,
  }) : super(key: key);

  final ManageComment commentController;
  final Widget? childWidget;
  final String currentUserId;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  SuperTooltip? tooltip;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      if (widget.childWidget != null)
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: size.width,
                            child: widget.childWidget,
                          ),
                        ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  // width: size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommenterImage(
                                        size: 50,
                                        StrIamgeUrl:
                                            '${widget.commentController.listOfComments[index].userImgUrl}',
                                        tempatyName:
                                            "${widget.commentController.listOfComments[index].userDispalyName}",
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CommentDisplayBox(
                                                comment: widget
                                                    .commentController
                                                    .listOfComments[index],
                                                manageComment: widget.commentController,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  LikeReply(
                                                    likeOnTap: () {
                                                      setState(() {
                                                        MyToolTips.likeSelect(
                                                          emojies: widget
                                                              .commentController
                                                              .getEmojiesForLike(),
                                                          context: context,
                                                          commentController: widget
                                                              .commentController,
                                                          mainId: widget
                                                              .commentController
                                                              .mainCommnetId,
                                                          subCommentId: widget
                                                              .commentController
                                                              .subCommentId,
                                                          isReply: true,
                                                          userId: widget
                                                              .currentUserId,
                                                        );
                                                      });
                                                    },
                                                    replyOnTap: () {
                                                      setState(() {
                                                        widget.commentController
                                                            .replyYes = true;
                                                        widget.commentController
                                                                .mainCommnetId =
                                                            index;
                                                        widget.commentController
                                                                .replyTo =
                                                            widget
                                                                .commentController
                                                                .listOfComments[
                                                                    index]
                                                                .commentedBy;
                                                      });
                                                    },
                                                    commentController: widget
                                                        .commentController,
                                                    isReply: false,
                                                    mainCommentId: index,
                                                    subCommentId: -1,
                                                    userId:
                                                        widget.currentUserId,
                                                  ),
                                                  Container(
                                                    child: CommentLiks(
                                                      list: widget
                                                          .commentController
                                                          .listOfComments[index]
                                                          .commentLikeCounts,
                                                      likeCount: widget
                                                          .commentController
                                                          .listOfComments[index]
                                                          .getLikeCount(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                for (int x = 0;
                                    x <
                                        widget
                                            .commentController
                                            .listOfComments[index]
                                            .replies
                                            .length;
                                    x++)
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25, bottom: 5),
                                    width: size.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommenterImage(
                                              size: 30,
                                              StrIamgeUrl:
                                                  "${widget.commentController.listOfComments[index].replies[x].userImgUrl}",
                                              tempatyName:
                                                  "${widget.commentController.listOfComments[index].replies[x].userDispalyName}",
                                              fontSize: 14,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: SubCommentDisplayBox(
                                                comment: widget
                                                    .commentController
                                                    .listOfComments[index]
                                                    .replies[x],
                                                manageComment: widget.commentController,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 35, bottom: 5),
                                              child: LikeReply(
                                                likeOnTap: () async {
                                                  setState(() {
                                                    MyToolTips.likeSelect(
                                                      emojies: widget
                                                          .commentController
                                                          .getEmojiesForLike(),
                                                      context: context,
                                                      commentController: widget
                                                          .commentController,
                                                      mainId: widget
                                                          .commentController
                                                          .mainCommnetId,
                                                      subCommentId: widget
                                                          .commentController
                                                          .subCommentId,
                                                      isReply: true,
                                                      userId:
                                                          widget.currentUserId,
                                                    );
                                                  });
                                                },
                                                replyOnTap: () {
                                                  setState(
                                                    () {
                                                      widget.commentController
                                                          .replyYes = true;
                                                      widget.commentController
                                                              .subCommnetReplyYes =
                                                          true;
                                                      widget.commentController
                                                              .mainCommnetId =
                                                          index;
                                                      widget.commentController
                                                          .subCommentId = x;
                                                      widget.commentController
                                                              .replyTo =
                                                          widget
                                                              .commentController
                                                              .listOfComments[
                                                                  index]
                                                              .replies[x]
                                                              .commentedBy;
                                                    },
                                                  );
                                                },
                                                mainCommentId: index,
                                                isReply: true,
                                                commentController:
                                                    widget.commentController,
                                                subCommentId: x,
                                                userId: widget.currentUserId,
                                              ),
                                            ),
                                            Container(
                                              child: CommentLiks(
                                                list: widget
                                                    .commentController
                                                    .listOfComments[index]
                                                    .replies[x]
                                                    .commentLikeCounts,
                                                likeCount: widget
                                                    .commentController
                                                    .listOfComments[index]
                                                    .replies[x]
                                                    .getLikeCount(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          },
                          childCount:
                              widget.commentController.listOfComments.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: kBlack.withOpacity(0.5),
                    ),
                  ),
                ),
                // height: 60,
                child: Column(
                  children: [
                    if (widget.commentController.replyTo != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                "Replying to : ${widget.commentController.replyTo}",
                            fontWeight: FontWeight.w900,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(
                                () {
                                  widget.commentController.replyCancel();
                                },
                              );
                            },
                            child: Icon(Icons.cancel_sharp),
                          )
                        ],
                      ),
                    if (widget.commentController.replyTo != null)
                      SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: CommentInput(
                            controller: widget.commentController.textController,
                            showImage: widget.commentController.canAddImage,
                            tagTO: widget.commentController.replyTo,
                            loadImage: () async {
                              var result = (await ManageImageComment()
                                  .getImageFormGalary())!;

                              if (result.isNotEmpty) {
                                // widget.commentController.listOfImage=[];
                                // widget.commentController.listOfImage =result;

                                try {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          new ViewImageComment(
                                        imageList: result,
                                        commentController:
                                            widget.commentController,
                                        userId: widget.currentUserId,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print('$e');
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomRoundButton(
                          onTap: () {
                            setState(
                              () {
                                var value = widget
                                    .commentController.textController.text;
                                if (value.trim().isEmpty) return;
                                if (widget.commentController.replyYes) {
                                  if (widget.commentController.mainCommnetId ==
                                      -1) {
                                    return;
                                  }
                                  widget.commentController.addSubComment(
                                      comment: value,
                                      mainCommentId: widget
                                          .commentController.mainCommnetId);
                                } else if (widget
                                    .commentController.subCommnetReplyYes) {
                                  if (widget.commentController.subCommentId ==
                                          -1 ||
                                      widget.commentController.mainCommnetId ==
                                          -1) return;
                                  widget.commentController.replyToSubCommnet(
                                      comment: value,
                                      mainCommentId: widget
                                          .commentController.mainCommnetId,
                                      subCommentId: widget
                                          .commentController.subCommentId);
                                } else {
                                  widget.commentController
                                      .addMainComment(comment: value);
                                }
                                widget.commentController.changCommentState();
                              },
                            );
                          },
                        )
                      ],
                    ),
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
