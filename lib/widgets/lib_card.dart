import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/providers/route.dart';

class LibCard extends StatelessWidget {
  const LibCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.deleteLib,
    required this.index,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function(int) deleteLib;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<RouteProvider>(context, listen: false)
          .updateRoute(AppRoutePath.library('register')),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Delete Library ?'),
                content: RichText(
                  text: TextSpan(
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'You are deleting library: ',
                      ),
                      TextSpan(
                        text: '$title.\n',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const TextSpan(
                          text:
                              'This action is not reversible, do you want to proceed anyway ?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      deleteLib(index);
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
