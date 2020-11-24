import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:triky_deck/app/deck-list.dart';
import 'package:triky_deck/model/deck-model.dart';

import 'app/404.dart';
import 'home/home.dart';
import 'app/spalsh-screen.dart';
import 'utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Decks decks = Decks();
  @override
  Widget build(BuildContext context) {
    final MyTheme theme = MyTheme(context);
    final botToastBuilder = BotToastInit();
    return GetMaterialApp(
      title: 'TrikyDeck | Decks',
      themeMode: ThemeMode.system,
      theme: theme.light,
      darkTheme: theme.dark,
      navigatorObservers: [BotToastNavigatorObserver()], //2.
      initialRoute: '/',
      builder: (context, child) {
        child = Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1440),
                child: child,
              ),
            ),
          ),
        );
        return botToastBuilder(context, child);
      },
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          settings: RouteSettings(name: '/home'),
        ),
      ]..addAll(
          decks.all.map(
            (e) => GetPage(
              name: e.slug,
              page: () => e.view,
              settings: RouteSettings(name: e.slug),
            ),
          ),
        ),
      onGenerateRoute: (s) {
        final DeckModel deck = decks.findDeckById(s.name);
        if (deck != null)
          return GetPageRoute(
            routeName: deck.slug,
            page: () => deck.view,
            settings: RouteSettings(name: deck.slug),
          );

        return GetPageRoute(routeName: '/notfound', page: () => UnknownPage());
      },
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownPage()),
    );
  }
}
