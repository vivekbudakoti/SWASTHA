import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: kWhite, borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const SizedBox(
                width: 5,
              ),
              Icon(
                icon,
                color: kPrimaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: kHeadingTextStyle.copyWith(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
