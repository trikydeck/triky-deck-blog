> ### Contents
> - Requirements
> - Creating `OAuth Client Id` in Google cloud console.
> - Implementing in Flutter.

### ***Reuirements***
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- Google Account & [Cloud Console](https://console.cloud.google.com)

### ***Creating `OAuth Client Id` in Google cloud console***

### ***Implementing in Flutter***

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
    if (!await confirm('Signing out ?')) return;
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
    setUser(null);
  }

  Future<String> _getIdToken() async {
    GoogleSignInAuthentication auth = await _user.authentication;
    return auth.idToken??'';
  }
````

