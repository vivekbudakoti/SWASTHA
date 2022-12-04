import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swastha/database/sql_helper.dart';
import 'package:swastha/models/data_model.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class AddSleep extends StatefulWidget {
  const AddSleep({Key? key}) : super(key: key);

  @override
  State<AddSleep> createState() => _AddSleepState();
}

class _AddSleepState extends State<AddSleep> {
  final List<int> items = [1, 2, 3, 4, 5, 6, 7, 8];
  int _taken = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      height: 450,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Enter Sleep Taken In Hours",
            style: kSubHeadingTextStyle,
          ),
          Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: DropdownButtonFormField(
                    value: 1,
                    decoration: kTextFieldDecoration,
                    iconEnabledColor: kPrimaryColor,
                    iconDisabledColor: kPrimaryColor,
                    items: items.map((int items) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: items,
                        child: Text('$items Hr.',
                            style: kHeadingTextStyle.copyWith(fontSize: 18)),
                      );
                    }).toList(),
                    onChanged: (dynamic v) {
                      _taken = int.parse(v.toString());
                    },
                  ))),
          Center(
            child: RoundedButton(
                title: "Done",
                colour: kPrimaryColor,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() async {
                      await SQLHelper.insertData(DataModel(
                          DateFormat('dd/MM/yyyy').format(DateTime.now()),
                          DateTime.now().weekday,
                          0,
                          0,
                          _taken,
                          0));
                      changeScreenReplacement(context, const Home());
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
