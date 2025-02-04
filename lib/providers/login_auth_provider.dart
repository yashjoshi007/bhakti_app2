import 'package:bhakti_app/config.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginAuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String userNameGoogle = "";

  // Function to build authentication buttons based on provided context
  List<Widget> buildAuthButtons(context) {
    final List<Map<String, dynamic>> buttonData = [
      {
        'label': appFonts.loginViaPhone,
        'color': appColor(context).appTheme.phoneClr,
        'iconPath': eSvgAssets.phoneAuth,
        'onTap': () => loginPhoneNavigator(context)
      },
      {
        'label': appFonts.loginViaGoogle,
        'color': appColor(context).appTheme.googleClr,
        'iconPath': eSvgAssets.googleAuth,
        'onTap': () => signInWithGoogle(context)
      },
      {
        'label': appFonts.loginViaFacebook,
        'color': appColor(context).appTheme.fbClr,
        'iconPath': eSvgAssets.fbAuth,
        'onTap': () => signInWithFacebook(context)
      },
      {
        'label': appFonts.signInWithEmail,
        'color': appColor(context).appTheme.emailClr,
        'iconPath': eSvgAssets.emailAuth,
        'onTap': () => loginEmailNavigator(context)
      }
    ];

    List<Widget> buttonsWithSpace = [];

    for (int i = 0; i < buttonData.length; i++) {
      buttonsWithSpace.add(AuthButtonLayout(
          label: buttonData[i]['label'],
          color: buttonData[i]['color'],
          iconPath: buttonData[i]['iconPath'],
          onTap: buttonData[i]['onTap']));

      if (i < buttonData.length - 1) {
        buttonsWithSpace.add(const SizedBox(height: Insets.i25));
      }
    }

    return buttonsWithSpace;
  }

  // Function to sign in with Google
  signInWithGoogle(context) async {
    // Trigger the authentication flow

    SharedPreferences? preferences;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    User? user = (await auth.signInWithCredential(credential)).user;
    notifyListeners();
    userNameGoogle = user!.email!;

    String? token = await user.getIdToken();

    final commonApi = Provider.of<CommonApiProvider>(context, listen: false);

    await commonApi.socialLogin(context, token);

    preferences = await SharedPreferences.getInstance();
    UserModel? userModel;
    await Future.delayed(DurationsClass.s2);
    userModel =
        UserModel.fromJson(json.decode(preferences.getString(session.user)!));
    debugPrint("userModel ${userModel.name}");
    if (userModel.name == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SetUpProfile();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const CommonBottomNavigationBar();
      }));
    }
  }

  // signInWithGoogle(context) async {
  //   // Get the Google sign-in account object
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await GoogleSignIn().signIn();

  //   if (googleSignInAccount != null) {
  //     // Get the Google Sign-In authentication object
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleSignInAccount.authentication;

  //     // Create a Firebase credential using the Google Sign-In authentication object
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );

  //     // Sign in to Firebase with the credential
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Get the user details
  //     final user = userCredential.user;

  //     SharedPreferences? preferences;

  //     preferences = await SharedPreferences.getInstance();
  //     UserModel? userModel;
  //     await Future.delayed(DurationsClass.s2);
  //     userModel = UserModel.fromJson(json.decode(user.toString()));
  //     debugPrint("userModel ${userModel.name}");
  //     if (userModel.name == null) {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) {
  //         return const SetUpProfile();
  //       }));
  //     } else {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) {
  //         return const CommonBottomNavigationBar();
  //       }));
  //     }
  //   }
  // }

  // Function to navigate to phone login screen
  loginPhoneNavigator(context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const PhoneLoginScreen();
    }));
  }

  // Function to sign in with Facebook
  Future<Resource?> signInWithFacebook(context) async {
    return null;

    // SharedPreferences? preferences;
    // try {
    //   final LoginResult result = await FacebookAuth.instance.login();
    //   switch (result.status) {
    //     case LoginStatus.success:
    //       final AuthCredential facebookCredential =
    //           FacebookAuthProvider.credential(result.accessToken!.token);
    //       final userCredential =
    //           await auth.signInWithCredential(facebookCredential);
    //       User? user =
    //           (await auth.signInWithCredential(facebookCredential)).user;
    //       notifyListeners();
    //       userNameGoogle = user!.email!;
    //
    //       String? token = await user.getIdToken();
    //
    //       final commonApi =
    //           Provider.of<CommonApiProvider>(context, listen: false);
    //
    //       await commonApi.socialLogin(context, token);
    //
    //       preferences = await SharedPreferences.getInstance();
    //       UserModel? userModel;
    //       await Future.delayed(DurationsClass.s2);
    //       userModel = UserModel.fromJson(
    //           json.decode(preferences.getString(session.user)!));
    //       debugPrint("userModel ${userModel.name}");
    //       if (userModel.name == null) {
    //         Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) {
    //           return const SetUpProfile();
    //         }));
    //       } else {
    //         Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) {
    //           return const CommonBottomNavigationBar();
    //         }));
    //       }
    //
    //       return Resource(status: Status.Success);
    //     case LoginStatus.cancelled:
    //       return Resource(status: Status.Cancelled);
    //     case LoginStatus.failed:
    //       return Resource(status: Status.Error);
    //     default:
    //       return null;
    //   }
    // } on FirebaseAuthException catch (e) {
    //   throw e;
    // }
  }

  // Function to sign in with Apple
  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthCredential = OAuthProvider('apple.com');
        final credential = oAuthCredential.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!));
        final userCredential = await auth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName}${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      default:
        throw UnimplementedError();
    }
  }

  // Function to navigate to email login screen
  loginEmailNavigator(context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const EmailLoginScreen();
    }));
  }
}

class Resource {
  final Status status;

  Resource({required this.status});
}

enum Status { success, error, cancelled }
