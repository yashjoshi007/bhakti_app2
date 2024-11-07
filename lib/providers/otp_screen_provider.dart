import 'package:bhakti_app/config.dart';

class OtpScreenProvider extends ChangeNotifier {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final otpFormKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false, isValid = false;

  // Function to handle verify button press
  verifyButton(context) async {
    if (otpFormKey.currentState!.validate()) {
      SharedPreferences? preferences;
      focusNode.unfocus();
      isLoading = true;
      notifyListeners();
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: PhoneLoginScreen.verify,
            smsCode: pinController.text);
        User? user = (await auth.signInWithCredential(credential)).user;
        String? token = await user!.getIdToken();
        final commonApi =
            Provider.of<CommonApiProvider>(context, listen: false);
        await commonApi.socialLogin(context, token);
        isValid = false;
        notifyListeners();
        preferences = await SharedPreferences.getInstance();
        UserModel? userModel;
//Map user = json.decode(preferences!.getString(session.user)!);
        await Future.delayed(DurationsClass.s2);
        if (preferences.getString(session.user) != null) {
          userModel = UserModel.fromJson(
              json.decode(preferences.getString(session.user)!));

          isLoading = false;
          notifyListeners();
          if (userModel.name == null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const SetUpProfile();
            }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const CommonBottomNavigationBar();
            }));
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const SetUpProfile();
          }));
        }
      } on FirebaseAuthException {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(language(context,appFonts.enterValidOTP))));
        isValid = true;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      }
    }
  }

  // Callback function for OTP input completion
  onCompleted(context, pin) {
    debugPrint('onCompleted: $pin');
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Callback function for OTP input change
  onChanged(value, context) {
    debugPrint('onChanged: ${value.length}');
    if (value.length == 6) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  // Validator function for OTP input
  validator(value,context) {
    if (value == null || value.length != 6) {
      return language(context,appFonts.enter6DigitOTP);
    }
    return null;
  }

  // Dispose method to clean up resources
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
