import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    Key? key,
    required this.title,
    required this.volume,
    this.rating,
    required this.lastConsulted,
    required this.stalenessPeriod,
    this.comments,
  }) : super(key: key);

  final String title;
  final String volume;
  final double? rating;
  final DateTime lastConsulted;
  final Duration stalenessPeriod;
  final String? comments;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Center(
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
