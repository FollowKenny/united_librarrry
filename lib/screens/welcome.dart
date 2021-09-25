import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/services/app_name.dart';
import 'package:united_library/services/auth.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome to ${AppName.fullAppName}. Powered by teamco'),
            actions: <Widget>[
              IconButton(
                onPressed: auth.signOut,
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: false,
                context: context,
                builder: (BuildContext context) {
                  return LibCreator();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
            tooltip: 'create new lib',
          ),
        );
      },
    );
  }
}

class LibCreator extends StatefulWidget {
  const LibCreator({Key? key}) : super(key: key);

  @override
  _LibCreatorState createState() => _LibCreatorState();
}

class _LibCreatorState extends State<LibCreator> {
  final creatorMedataList = <_CreatorField>[];
  final _nameController = TextEditingController();
  final _metadataController = <TextEditingController>[];
  final _metadaKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();

  void _addMetadata() {
    setState(
      () {
        _metadataController.add(TextEditingController());
        var metadataNumber = creatorMedataList.length + 1;
        if (metadataNumber == 1) {
          creatorMedataList.add(
            _CreatorField(
              text: 'Metadata ${metadataNumber} (Book Title for example)',
              controller: _metadataController.last,
            ),
          );
        } else {
          creatorMedataList.add(_CreatorField(
            text: 'Metadata ${metadataNumber}',
            controller: _metadataController.last,
          ));
        }
      },
    );
  }

  void _removeMetadata() {
    setState(
      () {
        creatorMedataList.removeLast();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        _CreatorHeadline(
          text: 'Name your new library',
        ),
        Form(
          key: _nameKey,
          child: _CreatorField(
            text: 'My awesome u-lib',
            controller: _nameController,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        _CreatorHeadline(text: 'Define the metadata of your library'),
        Flexible(
          child: Form(
            key: _metadaKey,
            child: ListView.builder(
                itemCount: creatorMedataList.length,
                itemBuilder: (context, i) => creatorMedataList[i]),
          ),
        ),
        ButtonBar(
          children: <IconButton>[
            IconButton(
              onPressed: (creatorMedataList.length >= 25) ? null : _addMetadata,
              icon: Icon(Icons.add),
              tooltip: 'add metadata',
            ),
            IconButton(
              onPressed: creatorMedataList.isEmpty ? null : _removeMetadata,
              icon: Icon(Icons.remove),
              tooltip: 'remove metadata',
            ),
          ],
          alignment: MainAxisAlignment.center,
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () => {
            if (_nameKey.currentState!.validate() &&
                _metadaKey.currentState!.validate())
              {
                print(_nameController.text),
                _metadataController.forEach((element) => print(element.text))
              }
          },
          child: Text('Create Lib'),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class _CreatorField extends StatelessWidget {
  final text;
  final controller;

  const _CreatorField({required this.controller, this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please name it. Really';
          }
          return null;
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: text,
        ),
        controller: controller,
      ),
    );
  }
}

class _CreatorHeadline extends StatelessWidget {
  final text;

  const _CreatorHeadline({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
