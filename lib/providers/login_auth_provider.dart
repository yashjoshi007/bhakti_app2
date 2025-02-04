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

  // Function to sign in with Google (original)
  // signInWithGoogle(context) async {
  //   // Trigger the authentication flow

  //   SharedPreferences? preferences;
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  //   User? user = (await auth.signInWithCredential(credential)).user;
  //   notifyListeners();
  //   userNameGoogle = user!.email!;

  //   String? token = await user.getIdToken();

  //   final commonApi = Provider.of<CommonApiProvider>(context, listen: false);

  //   await commonApi.socialLogin(context, token);

  //   preferences = await SharedPreferences.getInstance();
  //   UserModel? userModel;
  //   await Future.delayed(DurationsClass.s2);
  //   userModel =
  //       UserModel.fromJson(json.decode(preferences.getString(session.user)!));
  //   debugPrint("userModel ${userModel.name}");
  //   if (userModel.name == null) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return const SetUpProfile();
  //     }));
  //   } else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  //       return const CommonBottomNavigationBar();
  //     }));
  //   }
  // }

  signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Sign in with the credential
      User? user = (await auth.signInWithCredential(credential)).user;

      if (user == null) {
        // Sign-in failed
        return;
      }

      notifyListeners();
      userNameGoogle = user.email!;

      String? token = await user.getIdToken();

      final commonApi = Provider.of<CommonApiProvider>(context, listen: false);

      await commonApi.socialLogin(context, token);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      UserModel? userModel;
      await Future.delayed(DurationsClass.s2);

      // Check if user data exists in shared preferences
      String? userJson = preferences.getString(session.user);
      if (userJson == null) {
        // First time sign-in, navigate to profile setup
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const SetUpProfile();
        }));
      } else {
        // User data exists, parse it
        userModel = UserModel.fromJson(json.decode(userJson));
        debugPrint("userModel ${userModel.name}");
        if (userModel.name == null) {
          // User data is incomplete, navigate to profile setup
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const SetUpProfile();
          }));
        } else {
          // User data is complete, navigate to main screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CommonBottomNavigationBar();
          }));
        }
      }
    } catch (e) {
      // Handle errors
      debugPrint("Error during Google sign-in: $e");
    }
  }

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
