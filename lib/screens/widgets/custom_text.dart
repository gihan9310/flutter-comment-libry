import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.fontColor = kBlack,
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;

  final double fontSize;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: fontColor,
      ),
    );


  }


}
