import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:triky_deck/utils/constants.dart';
import 'package:triky_deck/utils/misc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tooltip(
            message: 'TrikyDeck',
            child: Hero(
              tag: 'trikydeck',
              child: CircleAvatar(
                minRadius: 30,
                maxRadius: 100,
                backgroundImage: NetworkImage(trikyImg),
              ),
            ),
          ),
          Div(
            colM: 6,
            colL: 4,
            child: LinearProgressIndicator(backgroundColor: Colors.transparent),
          ),
        ],
      ),
    );
  }

  void load() async {
    print('in /');
    await delay(2000);
    print('to /home if mounted');
    if (mounted) {
      print('to /home');
      Get.offAndToNamed('/home');
    }
  }
}
