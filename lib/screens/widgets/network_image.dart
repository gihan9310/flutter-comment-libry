import 'dart:io';

import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class NetworkImageWithErrorBuilder extends StatelessWidget {
  const NetworkImageWithErrorBuilder({
    Key? key,
    this.userImgUrl,
    this.noImageShowText = 'No',
  }) : super(key: key);

  final String? userImgUrl;
  final String? noImageShowText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (!userImgUrl!.startsWith("http"))
            Image.file(
              File('${userImgUrl}'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: kBlack,
                  alignment: Alignment.center,
                  child: CustomText(text: "${noImageShowText}"),
                );
              },
            ),
          if (userImgUrl!.startsWith("http"))
            Image.network(
              '${userImgUrl}', // this image doesn't exist
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return CustomText(
                  text:
                      "${noImageShowText!.length > 2 ? noImageShowText!.substring(0, 2) : '${noImageShowText}'}",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontColor: kWhite,
                );
              },
            ),
        ],
      ),
    );
  }
}
