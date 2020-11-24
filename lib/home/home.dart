import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:triky_deck/app/deck-list.dart';
import 'package:triky_deck/home/home-card.dart';
import 'package:triky_deck/model/deck-model.dart';
import 'package:triky_deck/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DeckModel> decks = Decks().all;

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        leading: Hero(
          tag: 'trikydeck',
          child: CircleAvatar(
            backgroundColor: Get.theme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: CircleAvatar(
                maxRadius: 26,
                backgroundImage: NetworkImage(trikyImg),
              ),
            ),
          ),
        ),
        title: Text(
          'Triky Deck',
          style: GoogleFonts.radley(fontSize: 26),
          overflow: TextOverflow.fade,
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.info_outline_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Responsive(
            alignment: WrapAlignment.spaceEvenly,
            children: decks.map((e) => HomeCard(e)).toList(),
          ),
        ),
      ),
    );
  }

  void load() {
    print('in /home');
  }
}
