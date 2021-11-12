import 'package:flutter/material.dart';
import 'package:united_library/model/library.dart';

class LibrariesProvider extends ChangeNotifier {
  LibrariesProvider() {
    _userLibs = getDummy();
    notifyListeners();
  }

  get userLibs => _userLibs;
  var _userLibs = <LibraryModel>[] ;

  List<LibraryModel> getDummy() {
    return [
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'Peter Pan', uid: '2'),
      LibraryModel(libName: 'Stings', uid: '3'),
      LibraryModel(libName: 'TV shows', uid: '4'),
      LibraryModel(libName: 'Movies', uid: '5'),
      LibraryModel(libName: 'Books', uid: '6'),
      LibraryModel(libName: 'Youtubers', uid: '7'),
      LibraryModel(libName: 'Recipes', uid: '8'),
      LibraryModel(libName: 'Jedi', uid: '9'),
      LibraryModel(libName: 'Peoples', uid: '10'),
      LibraryModel(libName: 'Courses', uid: '11'),
      LibraryModel(libName: 'Tasks', uid: '12'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
      LibraryModel(libName: 'The Enchanted Nightingale', uid: '1'),
    ];
  }
  
  void deleteLibrary(index) {
    _userLibs.removeAt(index);
    notifyListeners();
  }
}
