import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swastha/utils/styles.dart';

changeScreen(BuildContext context, Widget sceeen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => sceeen));
}

changeScreenReplacement(BuildContext context, Widget sceeen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => sceeen));
}

showProgressDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: SpinKitFadingCube(color: kPrimaryColor),
        );
      });
}
