import 'package:flutter/material.dart';

class LibraryModel {
  LibraryModel({
    required this.libName,
    required this.uid,
  });

  String libName;
  String uid;
  var libIcon = Icons.library_books;
  var commonFields = [
    'Name',
    'Volume',
    'Finished on',
    'Staleness period',
    'Ratings',
    'Comments'
  ];
  var customFields = [];
}
