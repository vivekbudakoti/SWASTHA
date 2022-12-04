import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swastha/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Resources extends StatelessWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: kWhite,
          mini: true,
          onPressed: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          )),
      body: Container(
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: SafeArea(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Resources',
            style: TextStyle(
                color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ResrouceTile(
                    title: "National Mental Health Program",
                    link: "www.nhp.gov.in",
                    ontap: () {
                      launch(
                          "https://www.nhp.gov.in/national-mental-health-programme_pg");
                    }),
                ResrouceTile(
                    title: "Very Well Mind",
                    link: "www.verywellmind.com",
                    ontap: () {}),
                ResrouceTile(
                    title: "Better Help",
                    link: "www.betterhelp.com",
                    ontap: () {}),
                ResrouceTile(
                    title: "Calm Sage", link: "www.calmsage.com", ontap: () {}),
              ],
            ),
          )),
        ])),
      ),
    );
  }
}

class ResrouceTile extends StatelessWidget {
  final String title;
  final String link;
  final ontap;
  const ResrouceTile(
      {Key? key, required this.title, required this.link, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.language,
                  color: kWhite,
                  size: 48,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  title,
                  style:
                      kHeadingTextStyle.copyWith(color: kWhite, fontSize: 20),
                ),
                Text(
                  link,
                  style: kSubHeadingTextStyle.copyWith(color: kWhite),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.trending_up,
                color: kWhite,
                size: 36,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
