import 'package:info_with_comments/dtos/comment_dto.dart';
import 'package:info_with_comments/dtos/commnet_liks.dart';
import 'package:info_with_comments/dtos/liked_users.dart';

class SubCommentDTO {
  String? id;
  String postId;
  String commentedBy;
  String userId;
  String userDispalyName;
  String? userImgUrl;
  String? tagTo;
  DateTime commentedDate;
  String comment;
  List<String> commentImgUrl;
  List<CommentLike> commentLikeCounts;
  List<LikedUser> likesUsers;


  SubCommentDTO({
    this.id,
    required this.postId,
    required this.commentedBy,
    required this.userId,
    required this.userDispalyName,
    this.userImgUrl="",
    this.tagTo,
    required this.commentedDate,
    required this.comment,
    required this.commentImgUrl,
    required this.commentLikeCounts,
    required this.likesUsers,
  });

  getLikeCount() {
    int count = 0;
    commentLikeCounts.forEach((element) {
      count += element.emojiCount;
    });

    return count;
  }

  String getMainCommentTime(){
    int deff =0;
    DateTime currentTime =DateTime.now();
    var commentTime = this.commentedDate;
    var difference = currentTime.difference(commentTime);
    deff =difference.inMinutes;
    return "${deff}m";
  }
}
