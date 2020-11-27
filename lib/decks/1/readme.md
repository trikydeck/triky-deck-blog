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
- Create New project / Select an existing project ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/1.webp)
- To Create an OAuth client ID, you must first set a `product name` on the `contest screen`  ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/2.webp)  ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/3.webp)
- [ *Application name field is enough for initial / demo purpose only. While filling other fields / uploading image you can proceed to verification* ]
- Go to `Credentials` menu
- Click `Create Credential` -> `OAuth Client ID` ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/4.webp)
- Select `Application type` as `Web Application`
- Add `Javascript origin` URIs [only `domain name`,(set port number if other than :80 )] and `create` ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/5.webp)
- javascript origin uses Popup window sign-in method (no uri redirection required)
- Copy the newly created `OAuth Client ID`  ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/6.webp)

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
