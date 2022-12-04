import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key, required this.icon, required this.onpressed})
      : super(key: key);
  final IconData icon;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      onPressed: onpressed,
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: const CircleBorder(),
      fillColor: kPrimaryColor,
      child: Icon(
        icon,
        color: kWhite,
      ),
    );
  }
}
