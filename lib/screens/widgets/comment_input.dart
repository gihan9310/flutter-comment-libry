import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/manage_image_comment.dart';
import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  CommentInput({
    required this.controller,
    Key? key,
    required this.loadImage,
    this.showImage = true,
    this.tagTO,
  }) : super(key: key);

  final TextEditingController controller;
  final Function() loadImage;
  final bool showImage;
  String? tagTO;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  Widget build(BuildContext context) {
    // widget.controller.text = (widget.tagTO==null ? '': '@${widget.tagTO} ');
    return Container(
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
          // prefixIcon: widget.tagTO == null
          //     ? null
          //     : CustomText(text: '${widget.tagTO}'),
          suffixIcon: widget.showImage == false
              ? null
              : Container(
                  padding: EdgeInsets.only(right: 10),
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          child: Icon(
                            Icons.image,
                            size: 30,
                          ),
                          onTap: widget.loadImage //async {
                          //
                          // },
                          )
                    ],
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

// InkWell(
//   child: Icon(
//     Icons.image,
//     size: 30,
//   ),
//   onTap: () async {
//    var result = await ManageImageComment().getImageFormGalary();
//
//   },
// ),
// Icon(
//   Icons.emoji_emotions_outlined,
//   size: 30,
// ),
// SizedBox(
//   width: 5,
// ),

// suffixIcon: InkWell(
// child: Icon(
// Icons.send,
// size: 30,
// ),
// onTap: onTap,
// )
