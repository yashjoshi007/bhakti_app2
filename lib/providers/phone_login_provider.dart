import 'package:bhakti_app/config.dart';

class PhoneLoginProvider extends ChangeNotifier {
  TextEditingController phoneNumber = TextEditingController();
  bool isLoading = false;
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String? countryCode;

  // Function to handle send OTP button press
  sendOtpButton(context) async {
    FocusScope.of(context)
        .requestFocus(FocusNode());
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance
        .verifyPhoneNumber(
        phoneNumber:
        "+$countryCode-${phoneNumber.text}",
        verificationCompleted:
            (PhoneAuthCredential
        credential) {
          isLoading = false;
          notifyListeners();
        },
        verificationFailed:
            (FirebaseAuthException e) {
          isLoading = false;
          notifyListeners();
        },
        codeSent: (String verificationId,
            int? resendToken) {
          PhoneLoginScreen.verify =
              verificationId;
          isLoading = false;
          notifyListeners();
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) {
                    return const OtpScreen();
                  }));
        },
        codeAutoRetrievalTimeout:
            (String verificationId) {
          isLoading = false;
         notifyListeners();
        });
  }

  // Callback function to handle country code change
  countryCodeChange(value){
  countryCode = value.countryCode;// Updates the selected country code
}

  // Validator function for phone number input
  validator(p0,context){
    if (p0!.number.isEmpty) {
      return language(context,appFonts.pleaseEnterYourNumber);
    }
    return null;
  }
}
