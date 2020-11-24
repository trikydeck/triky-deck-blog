import 'package:triky_deck/decks/1/view.dart';
import 'package:triky_deck/model/deck-model.dart';

class Decks {
  Decks() {
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
    _decks.add(DeckModel(
        title: 'Google Sign-in | without firebase', id: 1, view: DeckOne()));
  }
  final List<DeckModel> _decks = [];

  DeckModel findDeckById(String slug) =>
      _decks.firstWhere((e) => e.slug.startsWith(slug), orElse: () => null);

  List<DeckModel> get all => _decks;
}
