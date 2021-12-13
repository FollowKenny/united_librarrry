import 'package:flutter/material.dart';

class TitleModel {
  TitleModel.dummy()
    : uid = 'love',
      title = 'MyTitle',
      volume = 3,
      finishedOn = DateTime(2010, 10, 10),
      stalenessPeriod = Duration(days: 50),
      rating = 2.5,
      comments = 'So fucking awesome';

  String uid;
  String title;
  int volume;
  DateTime finishedOn;
  Duration stalenessPeriod;
  double rating;
  String comments;

  getDummies(int number) {
    var res = <TitleModel>[];
    for (int i = 1; i <= number; i++) {
      res.add(TitleModel.dummy());
    }
    return res;
  }
}