import 'dart:ffi';

import 'package:info_with_comments/controllers/colors_manager.dart';
import 'package:info_with_comments/dtos/comment_dto.dart';
import 'package:info_with_comments/dtos/commnet_liks.dart';
import 'package:info_with_comments/dtos/liked_users.dart';
import 'package:info_with_comments/dtos/sub_comment_dto.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:images_picker/images_picker.dart';

class ManageComment {
  List<CommentDTO> listOfComments = [];
  String? _userId;
  String? _userName;
  final TextEditingController textController = TextEditingController();


  bool replyYes = false;
  int mainCommnetId = -1;
  bool subCommnetReplyYes = false;
  int subCommentId = -1;
  bool canAddImage = true;
  String? replyTo = null;
  List<Media> listOfImage = [];

  //decoration properties
  Color mainCommentBoxColor  =kGreen;
  double mainBoxFontSize = 12.0 ;
  double mainUserNameFontSize = 13.0 ;
  FontWeight mainUserNameFontWeight =FontWeight.w800;
  bool mainBoxshowBoxShadow =true;

  //SUB COMMENT BOX PROPERTIES
  Color subCommentBoxColor  =kBlack;
  double subBoxFontSize = 12.0 ;
  double subCommentUserNameFontSize = 13.5 ;
  double tagToFontSize = 12.0 ;
  FontWeight subUserNameFontWeight =FontWeight.bold;
  FontWeight tagToWeight =FontWeight.w900;
  bool subBoxshowBoxShadow =false;

  addMainComment({required String comment, String? postId}) {
    var c = CommentDTO(
      postId: postId,
      commentedBy: "Test User",
      userId: "Login User Id",
      userDispalyName: "SA",
      commentedDate: DateTime.now(),
      comment: comment,
      commentImgUrl: [],
      commentLikeCounts: getEmojiesForLike(),
      replies: [],
      likesUsers: [],
    );
    listOfComments.add(c);
  }

  addSubComment(
      {required String comment, required int mainCommentId, String? postId}) {
    var reuslt = SubCommentDTO(
        postId: '$postId',
        commentedBy: "Sub Comment User",
        userId: "XXXXX-001",
        userDispalyName: "KM",
        commentedDate: DateTime.now(),
        comment: comment,
        commentImgUrl: [],
        commentLikeCounts: getEmojiesForLike(),
        likesUsers: [],
        tagTo: '@${replyTo}');
    listOfComments[mainCommentId].replies.add(reuslt);
  }

  updateComment(
      {required CommentDTO dto, required int index, String? postId}) {}

  updateSubComment(
      {required SubCommentDTO dto,
      required int mainCommentId,
      required int subCommentId}) {}

  deleteComment(
      {required CommentDTO dto,
      required int mainCommentId,
      String? postId,
      String}) {}

  deleteSubComment(
      {required SubCommentDTO dto,
      required int mainCommentId,
      String? postId}) {}

  editComment({required CommentDTO dto, required int index, String? postId}) {}

  editSubComment(
      {required SubCommentDTO dto,
      required int mainCommentId,
      required int subCommentId,
      String? postId}) {}

  replyToSubCommnet(
      {required String comment,
      required int mainCommentId,
      required subCommentId,
      String? postId}) {}

  List<CommentLike> getEmojiesForLike() {
    List<CommentLike> list = [];
    list.add(new CommentLike(index: 1, emoji: "😇", emojiCount: 0));
    list.add(new CommentLike(index: 2, emoji: "❤", emojiCount: 0));
    list.add(new CommentLike(index: 3, emoji: "😡", emojiCount: 0));
    list.add(new CommentLike(index: 4, emoji: "😀", emojiCount: 0));
    list.add(new CommentLike(index: 5, emoji: "😡", emojiCount: 0));
    list.add(new CommentLike(index: 6, emoji: "❤", emojiCount: 0));
    list.add(new CommentLike(index: 7, emoji: "😀", emojiCount: 0));
    return list;
  }

  likeForMainComment(
      {required int likeTypeId,
      required String likeType,
      required int mainCommentId,
      String? postId,
      required String userId}) {
    String isUpdateOrNew = "N";
    int currentEmojiId = -1;
    int updateLikeId = -1;
    for (int x = 0; x < listOfComments[mainCommentId].likesUsers.length; x++) {
      if (userId == listOfComments[mainCommentId].likesUsers[x].userId) {
        if (listOfComments[mainCommentId].likesUsers[x].emojiId != likeTypeId) {
          isUpdateOrNew = "U";
          currentEmojiId = listOfComments[mainCommentId].likesUsers[x].emojiId;
          updateLikeId = x;
        } else {
          isUpdateOrNew = "O";
          return;
        }
        break;
      }
    }
    if (isUpdateOrNew == "U") {
      --listOfComments[mainCommentId]
          .commentLikeCounts[currentEmojiId]
          .emojiCount;
      ++listOfComments[mainCommentId].commentLikeCounts[likeTypeId].emojiCount;
      listOfComments[mainCommentId].likesUsers[updateLikeId].emoji = likeType;
      listOfComments[mainCommentId].likesUsers[updateLikeId].emojiId =
          likeTypeId;
    } else if (isUpdateOrNew == "N") {
      ++listOfComments[mainCommentId].commentLikeCounts[likeTypeId].emojiCount;
      var like = LikedUser(userId, likeTypeId, likeType);
      listOfComments[mainCommentId].likesUsers.add(like);
    } else {
      return;
    }
  }

  likeForSubComment(
      {required int likeTypeId,
      required String likeType,
      required int mainCommentId,
      required int subCommentID,
      String? postId,
      required String userId}) {
    String isUpdateOrNew = "N";
    int currentEmojiId = -1;
    int updateLikeId = -1;

    for (int x = 0;
        x <
            listOfComments[mainCommentId]
                .replies[subCommentID]
                .likesUsers
                .length;
        x++) {
      if (userId ==
          listOfComments[mainCommentId]
              .replies[subCommentID]
              .likesUsers[x]
              .userId) {
        if (listOfComments[mainCommentId]
                .replies[subCommentID]
                .likesUsers[x]
                .emojiId !=
            likeTypeId) {
          isUpdateOrNew = "U";
          currentEmojiId = listOfComments[mainCommentId]
              .replies[subCommentID]
              .likesUsers[x]
              .emojiId;
          updateLikeId = x;
        } else {
          isUpdateOrNew = "O";
          return;
        }
        break;
      }
    }
    if (isUpdateOrNew == "U") {
      --listOfComments[mainCommentId]
          .replies[subCommentID]
          .commentLikeCounts[currentEmojiId]
          .emojiCount;
      ++listOfComments[mainCommentId]
          .replies[subCommentID]
          .commentLikeCounts[likeTypeId]
          .emojiCount;
      listOfComments[mainCommentId]
          .replies[subCommentID]
          .likesUsers[updateLikeId]
          .emoji = likeType;
      listOfComments[mainCommentId]
          .replies[subCommentID]
          .likesUsers[updateLikeId]
          .emojiId = likeTypeId;
    } else if (isUpdateOrNew == "N") {
      ++listOfComments[mainCommentId]
          .replies[subCommentID]
          .commentLikeCounts[likeTypeId]
          .emojiCount;
      var like = LikedUser(userId, likeTypeId, likeType);
      listOfComments[mainCommentId].replies[subCommentID].likesUsers.add(like);
    } else {
      return;
    }
  }

  imageComment(
      {String? postId,
      required String userId,
      required List<Media> list}) async {
    try {
      List<String> imagePaths = [];
      if (list.isNotEmpty) {
        list.forEach((element) {
          imagePaths.add(element.path);
        });
      }

      if (replyYes) {
        var subComment = SubCommentDTO(
          postId: '$postId',
          commentedBy: "commentedBy",
          userId: "XXXXX-001",
          userDispalyName: "KM",
          commentedDate: DateTime.now(),
          comment: textController.text,
          commentImgUrl: imagePaths,
          commentLikeCounts: getEmojiesForLike(),
          likesUsers: [],
          tagTo: '@${replyTo}',
        );
        listOfComments[mainCommnetId].replies.add(subComment);
        changCommentState();
      } else {
        var mainComment = CommentDTO(
          postId: '$postId',
          commentedBy: "Login User",
          userId: "Login User Id",
          userDispalyName: "SA",
          commentedDate: DateTime.now(),
          comment: textController.text,
          commentImgUrl: imagePaths,
          commentLikeCounts: getEmojiesForLike(),
          replies: [],
          likesUsers: [],
        );

        listOfComments.add(mainComment);
        changCommentState();
      }
    } catch (e) {
      changCommentState();
    }
  }

  String getMainCommentTime(int mainComentIndex) {
    int deff = 0;
    DateTime currentTime = DateTime.now();
    var commentTime = listOfComments[mainComentIndex].commentedDate;
    var difference = currentTime.difference(commentTime);
    deff = difference.inMinutes;
    return "${deff}m";
  }

  String getImageUril(int index, List<Media> list) {
    return '${list[index].thumbPath}';
  }

  changCommentState() {
    textController.text = '';
    mainCommnetId = -1;
    replyYes = false;
    subCommentId = -1;
    subCommnetReplyYes = false;
    replyTo = null;
    listOfImage = [];
  }

  replyCancel() {
    mainCommnetId = -1;
    replyYes = false;
    subCommentId = -1;
    subCommnetReplyYes = false;
    replyTo = null;
  }

  clearAllComment() {
    listOfComments = [];
  }

}
