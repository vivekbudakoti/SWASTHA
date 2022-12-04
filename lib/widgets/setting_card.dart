import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class SettingsCard extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  // When enabled, the top border is rounded
  final bool start;
  // When enabled, the bottom border is rounded
  final bool end;
  const SettingsCard(
      {required this.leading,
      required this.title,
      required this.trailing,
      this.start = false,
      this.end = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      margin: const EdgeInsets.only(bottom: 1.0, left: 21.0, right: 21.0),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(start ? 20.0 : 0.0),
          bottom: Radius.circular(end ? 20.0 : 0.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 1, child: leading),
          Expanded(flex: 2, child: title),
          Expanded(flex: 2, child: trailing),
        ],
      ),
    );
  }
}
