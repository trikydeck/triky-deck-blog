import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:triky_deck/utils/code-view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/popups.dart';
import '../../utils/constants.dart';

class DeckOne extends StatefulWidget {
  @override
  _DeckOneState createState() => _DeckOneState();
}

class _DeckOneState extends State<DeckOne> {
  GoogleSignIn googleSignIn = GoogleSignIn(clientId: clientId);

  GoogleSignInAccount _user;

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool pop = Navigator.canPop(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Google sign-in | Without Firebase'),
        leading: pop
            ? null
            : IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Get.toNamed('/home');
                },
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SourceCodeView(
                url:
                    "https://gist.githubusercontent.com/trikydeck/255449e7c6b7b610fccdcd143d9d4339/raw/9963999a29ef452fc41ad8009dc7e285351bcb57/deck-1.dart"),
            _user == null
                ? Div(
                    colM: 4,
                    colL: 3,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      color: Get.theme.primaryColor,
                      elevation: 0,
                      highlightElevation: 0,
                      hoverElevation: 0,
                      child: Image.asset('res/1/g_sign_btn.png'),
                      onPressed: _startGoogleSignIn,
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Signed in as',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Div(
                        colM: 6,
                        colL: 4,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(_user.photoUrl),
                          ),
                          title: Text(_user.displayName),
                          subtitle: Text(_user.email),
                          onTap: _signOut,
                          trailing: Icon(Icons.exit_to_app),
                        ),
                      ),
                      FutureBuilder<GoogleSignInAuthentication>(
                        future: _user.authentication,
                        builder: (_,
                            AsyncSnapshot<GoogleSignInAuthentication>
                                snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton.icon(
                                icon: Text('ID Token'),
                                label: Icon(Icons.open_in_new),
                                onPressed: () {
                                  launch(
                                      "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=${snapshot.data.idToken}");
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error getting ID Token : ${snapshot.error.toString()}');
                          }
                          return CircularProgressIndicator();
                        },
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void _startGoogleSignIn() async {
    toast('Signing out (if already signed-in)');
    await googleSignIn.signOut(); //optional
    GoogleSignInAccount user = await googleSignIn.signIn();
    setUser(user);
  }

  void load() async {
    bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      GoogleSignInAccount user = await googleSignIn.signInSilently();
      setUser(user);
    }
  }

  void setUser(GoogleSignInAccount user) {
    setState(() {
      _user = user;
    });
    if (user == null) {
      toast('No sign-in');
      return;
    }
    toast('Welcome ${user.displayName}');
  }

  void _signOut() async {
    if (!await confirm('Signing out ?')) return;
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
    setUser(null);
  }
}
