import 'dart:io';

import 'package:info_with_comments/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NetworkImageWithErrorBuilder extends StatelessWidget {
  const NetworkImageWithErrorBuilder({
    Key? key,
    this.userImgUrl,
     this.noImageShowText ='No',
  }) : super(key: key);

  final String? userImgUrl;
  final String? noImageShowText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        '${userImgUrl}', // this image doesn't exist
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.file(
            File('${userImgUrl}'),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.amber,
                alignment: Alignment.center,
                child:CustomText(text: "${noImageShowText}"),
              );
            } ,
          );
        },
      ),
    );
  }
}