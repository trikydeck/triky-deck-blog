import 'package:flutter/material.dart';

class DeckModel {
  final String title;
  final int id;
  final Widget view;

  DeckModel({
    @required this.title,
    @required this.id,
    @required this.view,
  });

  String get slug =>
      "/" +
      title
          .toLowerCase()
          .split(' ')
          .join('-')
          .replaceAll('|', '')
          .replaceAll('--', '-');
}
