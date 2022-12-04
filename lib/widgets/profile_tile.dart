import 'package:flutter/material.dart';
import 'package:swastha/utils/styles.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final VoidCallback ontap;

  const ProfileTile({
    Key? key,
    required this.title,
    required this.ontap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      title,
                      style: kHeadingTextStyle.copyWith(
                          fontSize: 20,
                          color: kWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: ontap,
                    child: const Icon(
                      Icons.edit,
                      color: kWhite,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
