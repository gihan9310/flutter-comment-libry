import 'dart:io';
import 'dart:ui';

import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CommenterImage extends StatelessWidget {
  const CommenterImage({
    required this.size,
    required this.StrIamgeUrl,
    required this.tempatyName,
    this.fontSize = 16,
    Key? key,
  }) : super(key: key);

  final double size;
  final String tempatyName;
  final StrIamgeUrl;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size < 35
          ? 35
          : size > 60
              ? 60
              : size,
      // change misleading user image size set user can use 35 - 60 range what ever
      height: size < 35
          ? 35
          : size > 60
              ? 60
              : size,
      // margin: EdgeInsets.all(100.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size < 35
            ? 35
            : size > 60
                ? 60
                : size),
        child: Image.network(
          '${StrIamgeUrl}', // this image doesn't exist
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.file(
              File('${StrIamgeUrl}'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    text:
                        "${tempatyName.length > 2 ? tempatyName.substring(0, 2) : tempatyName}",
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontColor: kWhite,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
