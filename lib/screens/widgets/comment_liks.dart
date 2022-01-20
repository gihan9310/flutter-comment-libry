import 'package:info_with_comments/dtos/commnet_liks.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/screens/widgets/tool_tips.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class CommentLiks extends StatelessWidget {
  CommentLiks({
    required this.list,
    required this.likeCount,
    Key? key,
  }) : super(key: key);

  final List<CommentLike> list;
  SuperTooltip? tooltip;
  final int likeCount ;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Container(
      padding: EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int x = 0; x < list.length; x++)
            if (list[x].emojiCount > 0)
              InkWell(
                onTap: () {
                  MyToolTips.showLiksCount(
                      context: context, list: list, tooltip: tooltip);
                },
                child: Transform.translate(
                  offset: Offset(-(1 * x.toDouble() * 4), 0),
                  child: CustomText(text: list[x].emoji),
                ),
              ),
          Transform.translate(
            offset: Offset(-0, 0),
            child: CustomText(
              text:likeCount ==0 ?'': likeCount<1000 ? "${likeCount}":"${likeCount/1000}K",
            ),
          ),
        ],
      ),
    );

    showToolTips() {}
  }
}
