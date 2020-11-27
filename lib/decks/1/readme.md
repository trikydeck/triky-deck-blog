> ## Contents
> - Requirements
> - Creating `OAuth Client Id` in Google cloud console
> - Configuring Flutter web
> - Implementing GSign-in in Flutter
> - Getting ID Token

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

## **Configuring Flutter web**
- Switch to `beta channel` to enable Flutter web [type the below command in terminal]

> flutter channel beta
> 
> flutter upgrade
> 
> flutter config --enable-web

- After switching to beta, creating new project will have `web` enabled.
- To get support for existing project use the below command inside the project

> flutter create .

*. (note the `dot` at the end)*

- Flutter web uses `random port` everytimr when start debugging, so a `custom port` number need to be set.
- As I have mentioned my localhost port number as :2000, below command will be used to launch the web application in defined web port
> flutter run -d chrome --web-port 2000

> flutter run -d edge --web-port 2000

> flutter run -d web-server --web-port 2000

- `VSCode` users can add the command in `launch.json` ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/7.webp)

- For `Android Studio`, add the command in run/debug configurations ![image info](https://i.stack.imgur.com/c1oLj.png)

## **Implementing Google Sign-in in Flutter**
- Add `google_sign_in` package in pubspec.yaml
- Import in project 
````dart
import 'package:google_sign_in/google_sign_in.dart';
````

- Initialize `GoogleSignIn` with `clientId` copied from Google cloud console
````dart
GoogleSignIn googleSignIn = GoogleSignIn(clientId: "<clientId>");

GoogleSignInAccount _user;
````

- A common method to set `_user`
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
````

- Initiate signing and set _user
````dart
void _startGoogleSignIn() async {
  print('Signing out (if already signed-in)');
  await googleSignIn.signOut(); //optional
  GoogleSignInAccount user = await googleSignIn.signIn();
  setUser(user);
}
````

- You can check for any `existing user` [try in initState]
````dart
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
````

- Sign out and disconnect the user
````dart
void _signOut() async {
    print('Signing out');
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
    setUser(null);
}
````

## **Getting ID Token**
- ID Token can be fetch from authentication
````dart
Future<String> _getIdToken() async {
  GoogleSignInAuthentication auth = await _user.authentication;
  return auth.idToken??'';
}
````
- No additional configurations need for web
- `But` to get ID Token in Android some `additional works to be done`
  - create a file in `android\app\src\main\res\values\strings.xml`
  - Add the following lines
  - `Replace` with your Web Application OAuth ClientID
````xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="default_web_client_id">xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com</string>
</resources>
````
![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/9.webp)

- Create a new `Android` OAuth Client ID in Cloud Console
- Add Application `package name`
- Add `SHA-1` certificate fingerprint
- Click on Create button to create Client ID ![image info](https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/1/img/8.webp)
  - Note : In String.xml you need to `provide Web Application Client ID not the Android Client ID`
  - Note : We are not going to use this android Client ID in our project, but to get ID Token during sig-in, our app need to be verified by google cloud using package name & SHA-1

- Send the ID Token to the backend
- `Decode` the ID Token using the below link
  > https://www.googleapis.com/oauth2/v3/tokeninfo?id_token={put the token here}
- Parse the json and verify your Client-ID with `azp` and `aud`
- Then get the `email` from json.

- `That's all :-)`

## **Test Google sign-in flutter in Realtime**


