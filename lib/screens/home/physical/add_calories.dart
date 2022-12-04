import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:swastha/database/sql_helper.dart';
import 'package:swastha/models/data_model.dart';
import 'package:swastha/screens/home.dart';
import 'package:swastha/services/change_screen.dart';
import 'package:swastha/utils/styles.dart';
import 'package:swastha/widgets/round_button.dart';

class AddCalories extends StatefulWidget {
  const AddCalories({Key? key}) : super(key: key);

  @override
  State<AddCalories> createState() => _AddCaloriesState();
}

class _AddCaloriesState extends State<AddCalories> {
  int _taken = 100;
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
            "Enter Amount of Calories : ",
            style: kSubHeadingTextStyle,
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: '100',
                  keyboardType: TextInputType.number,
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter Caloreis', hintText: 'Caloreis'),
                  onChanged: (value) {
                    _taken = int.parse(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "It Can't Be Empty";
                    } else if (int.parse(value) > 1000) {
                      return 'it must be less than 1000';
                    } else {
                      return null;
                    }
                  },
                ),
              )),
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
                          _taken,
                          0,
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
