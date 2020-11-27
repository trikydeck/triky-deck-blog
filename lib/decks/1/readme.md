> ## Contents
> - Requirements
> - Creating `OAuth Client Id` in Google cloud console
> - Enabling Flutter web
> - Implementing in Flutter

## **Requirements**
- Flutter - Beta channel
- [google_sign_in](https://pub.dev/packages/google_sign_in) package
- Google Account & [Cloud Console](https://console.cloud.google.com) to generate OAutho 2.0 client ID
- Supported Browser [`chrome`,`Edge`]

## **Creating `OAuth Client Id` in Google cloud console**
- Navigate to [Google Cloud Console](https://console.cloud.google.com) 
- Create New project / Select an existing project

![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/1.webp)

## **Implementing in Flutter**

- Create GoogleSignIn :
````dart
GoogleSignIn googleSignIn = GoogleSignIn(clientId: "<clientId>");

GoogleSignInAccount _user;
````
- Check | Sign-in | Set | Sign-out :
````dart
  void setUser(GoogleSignInAccount user) {
    setState(() {
      _user = user;
    });
    if (user == null) {
      print('No sign-in');
      return;
    }
    print('Welcome ${user.displayName}');
  }

  void checkExistingSignIn() async {
    bool isSignedIn = await googleSignIn.isSignedIn();
    if (isSignedIn) {
      // GoogleSignInAccount user = googleSignIn.currentUser; 
      // will get current sign-in user 
      // `but` to get IdToken a silent Signin requires ! 
      GoogleSignInAccount user = await googleSignIn.signInSilently();
      setUser(user);
    }
  }

  void _startGoogleSignIn() async {
    print('Signing out (if already signed-in)');
    await googleSignIn.signOut(); //optional
    GoogleSignInAccount user = await googleSignIn.signIn();
    setUser(user);
  }

  void _signOut() async {
    print('Signing out ?');
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
    setUser(null);
  }

  Future<String> _getIdToken() async {
    GoogleSignInAuthentication auth = await _user.authentication;
    return auth.idToken??'';
  }
````
