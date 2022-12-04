import 'dart:math';

import 'package:swastha/models/quote.dart';

import 'constants.dart';

Quote getQuote() {
  var r = Random(DateTime.now().millisecondsSinceEpoch);
  
  var randInt = r.nextInt(kQuote.length);
  return kQuote[randInt];
}