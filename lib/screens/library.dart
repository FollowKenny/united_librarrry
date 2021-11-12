import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/providers/libraries.dart';
import 'package:united_library/widgets/app_drawer.dart';
import 'package:united_library/widgets/lib_card.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Libraries'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
        tooltip: 'create new lib',
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: ChangeNotifierProvider(
        create: (context) => LibrariesProvider(),
        child: Consumer<LibrariesProvider>(
          builder: (context, libs, child) {
            return ListView.builder(
              itemCount: libs.userLibs.length,
              itemBuilder: (context, index) {
                return LibCard(
                    icon: libs.userLibs[index].libIcon,
                    title: libs.userLibs[index].libName,
                    deleteLib: libs.deleteLibrary,
                    index: index,);
              },
            );
          },
        ),
      ),
    );
  }
}
