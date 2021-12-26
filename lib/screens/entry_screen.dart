import "package:flutter/material.dart";
import 'package:united_library/widgets/details_card.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details'),
        centerTitle: true,
      ),
      body: DetailsCard(
        title: "Test",
        volume: "1",
        lastConsulted: DateTime(2020, 9, 1),
        stalenessPeriod: const Duration(days: 365),
        comments: "Truly awesome",
        rating: 3.5,
      ),
    );
  }
}
