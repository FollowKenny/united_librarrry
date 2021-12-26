import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/model/entry.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/providers/route.dart';

class LibraryScreen extends StatelessWidget {
  final String uid;
  final titles = TitleModel.dummy().getDummies(100);

  LibraryScreen({required this.uid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Entries'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: titles.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            child: Card(
              child: Text(titles[index].title),
            ),
            onTap: () =>
                Provider.of<RouteProvider>(context, listen: false).updateRoute(
              AppRoutePath.entry(
                'rfaz',
                'fae',
              ),
            ),
          );
        },
      ),
    );
  }
}
