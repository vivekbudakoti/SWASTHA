import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class SlideTile extends StatelessWidget {
  const SlideTile(
      {Key? key,
      required this.imageAssetPath,
      required this.title,
      required this.description})
      : super(key: key);
  final String imageAssetPath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png',width: 100,height: 100,),
        const SizedBox(
          height: 20,
        ),
        Text(title,
          textAlign :TextAlign.center,
          style: kHeadingTextStyle,),
        const SizedBox(
          height: 12,
        ),
        Text(description,
        textAlign: TextAlign.center,
        style:  kSubHeadingTextStyle ),
        const SizedBox(
          height: 30,
        ),
        Image.asset(imageAssetPath,height:360,),
      ],
    );
  }
}
