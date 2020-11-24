import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:triky_deck/model/deck-model.dart';

class HomeCard extends StatefulWidget {
  HomeCard(this.d);
  final DeckModel d;

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  DeckModel d;
  bool hover = false;
  @override
  void initState() {
    d = widget.d;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Div(
      colM: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: InkWell(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          "res/${d.id}/${d.id}.webp",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: SelectableText(
                              d.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        height: hover ? constraints.maxWidth / 7.5 : 0,
                      )
                    ],
                  ),
                );
              },
            ),
            // mouseCursor: Mo,
            onTap: () {
              Get.toNamed(d.slug);
            },
            onHover: (h) {
              setState(() {
                hover = h;
              });
            },
          ),
        ),
      ),
    );
  }
}
