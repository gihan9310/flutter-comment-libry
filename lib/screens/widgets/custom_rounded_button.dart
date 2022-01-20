import 'package:info_with_comments/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({
    Key? key, required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:kGreen

        ),
        child: Icon(
          Icons.send,
          size: 20,
          color: kWhite,
        ),
      ),
      onTap: onTap,
    );
  }
}
