import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swastha/models/quote.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({Key? key, required this.quote}) : super(key: key);
  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/c1.png')),
              Text(
                '“${quote.body}”',
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              Text(
                quote.author,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 36.0),
              RoundedButton(
                  title: 'Home',
                  colour: kPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
            ],
          ).padding(horizontal: 48.0),
        ),
      ),
    );
  }
}
