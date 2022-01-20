import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:info_with_comments/utils/colors_utils.dart';

class ManageImageComment {


  Future<List<Media>?> getImageFormGalary() async {
    try {
      return await ImagesPicker.pick(count: 10, pickType: PickType.image);
    } catch (e) {
      print("=============|||||||||| ${e}");
      return null;
    }
  }

  Future<List<Media>?> getImageFromCamara() async {
    try {
      return await ImagesPicker.openCamera(
          pickType: PickType.image, maxTime: 15);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonTex,
    required this.onTap,
  }) : super(key: key);

  final String buttonTex;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kBlack),
        child: CustomText(
          text: buttonTex,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontColor: Colors.white,
        ),
      ),
    );
  }
}
