import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff7A64E4);

const Color kSecondaryColor = Color(0xff59595d);

const Color kActiveSelect = Color(0xff9B99F9);

const Color kWhite = Colors.white;

const Color kGrey = Color(0xfffafafa);

const TextStyle kHeadingTextStyle = TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
const TextStyle kSubHeadingTextStyle = TextStyle(
  fontSize: 18,
  fontStyle: FontStyle.italic,
  color: kSecondaryColor,
);

const TextStyle kNormalTextStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: kSecondaryColor,
);
const TextStyle kLinkTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  decoration: TextDecoration.underline,
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  labelStyle: TextStyle(color: kPrimaryColor),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);
