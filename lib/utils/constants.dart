import 'package:flutter/cupertino.dart';
import 'package:swastha/models/quote.dart';

const List<Color> barColor = [
  Color(0xff19bfff),
  Color(0xffff4d94),
  Color(0xff2bdb90),
  Color(0xffffdd80),
  Color(0xff2bdb90),
  Color(0xffffdd80),
  Color(0xffff4d94)
];

const List<String> weekday = [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thus",
  "Fri",
  "Sat",
];

const List<Duration> kPresetTimers = <Duration>[
  Duration(minutes: 1),
  Duration(minutes: 5),
  Duration(minutes: 10),
  Duration(minutes: 15),
  Duration(minutes: 20),
  Duration(minutes: 30),
  Duration(minutes: 45),
  Duration(minutes: 60),
  Duration(minutes: 120),
];

List<Quote> kQuote = [
  Quote(
    author: 'Aristotle',
    body: 'Whosoever is delighted in solitude is either a wild beast or a god.',
  ),
  Quote(
    author: 'Paramahansa Yogananda',
    body: 'Seclusion is the price of greatness.',
  ),
  Quote(
    author: 'John Miller',
    body:
        'People who take the time to be alone usually have depth, originality, and quiet reserve.',
  ),
  Quote(
    author: 'Giovanni Papini',
    body: 'Breathing is the greatest pleasure in life',
  ),
  Quote(
    author: 'Oprah Winfrey',
    body:
        'Breathe. Let go. And remind yourself that this very moment is the only one you know you have for sure.',
  ),
  Quote(
    author: 'Thich Nhat Hanh',
    body: 'Breathe in deeply to bring your mind home to your body.',
  ),
  Quote(
    author: 'Dr. Arthur C. Guyton',
    body:
        'All chronic pain, suffering, and diseases are caused by a lack of oxygen at the cell level.',
  ),
  Quote(
    author: 'Gregory Maguire',
    body: 'Remember to breathe. It is after all, the secret of life.',
  ),
  Quote(
    author: 'Lana Parrilla',
    body: 'You are where you need to be. Just take a deep breath.',
  ),
  Quote(
    author: 'Unknown',
    body: 'A healthy miind has an easy breath.',
  ),
  Quote(
    author: 'Proverb',
    body: 'The nose is for breathing, the mouth is for eating.',
  ),
  Quote(
    author: 'Elizabeth Barrett Browning',
    body: 'He lives most life whoever breathes most air.',
  ),
  Quote(
    author: 'Peter Matthiessen',
    body:
        'In this very breath that we now take lies the secret that all great teachers try to tell us.',
  ),
  Quote(
    author: 'Sylvia Plath',
    body:
        'I took a deep breath and listened to the old bray of my heart: I am, I am, I am.',
  ),
];
