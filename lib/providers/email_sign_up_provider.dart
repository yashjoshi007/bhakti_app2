import 'dart:developer';

import 'package:bhakti_app/config.dart';

class EmailSignUpProvider extends ChangeNotifier {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  bool value = false;
  String? passwordValid, emailValid;
  final signUpFormKey = GlobalKey<FormState>();

  bool isHide = true;

  // Validates the password field and displays appropriate error messages
  passwordTextField(value, context) {
    if (value.isEmpty ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
      value.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(language(context,appFonts.enterPassword),
              style: appCss.dmDenseRegular16
                  .textColor(appColor(context).appTheme.primary))))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(language(context,appFonts.weekPassword),
              style: appCss.dmDenseRegular16
                  .textColor(appColor(context).appTheme.primary))));
      passwordValid = language(context,appFonts.enterValidEmail);

      notifyListeners();
      return language(context,appFonts.enterAValidPassword);
    } else {
      passwordValid = null;
      return null;
    }
  }

  // Validates the email field and displays appropriate error messages
  emailTextField(value,context) {
    notifyListeners();
    if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      emailValid = language(context,appFonts.enterValidEmail);
      return language(context,appFonts.enterValidEmail);
    } else {
      emailValid = null;
      return null;
    }
  }

  // Navigates back to the previous screen and clears the email and password fields
  alreadyAccountNavigate(context) {
    Navigator.pop(context);
    emailId.text = "";
    password.text = "";
  }

  // Toggles the visibility of the password field
  isShowPassword() {
    isHide = !isHide;
    notifyListeners();
  }

  // Handles the navigation and validation for the email signup process
  emailSignupNavigate(context) async {
    if (signUpFormKey.currentState!.validate()) {
      notifyListeners();
      try {
        showLoading(context);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailId.text,
          password: password.text,
        );
        log('$credential');
        hideLoading(context);
        Navigator.pop(context);
        emailId.text = "";
        password.text = "";
      } on FirebaseAuthException catch (e) {
        hideLoading(context);
        if (e.code == language(context,appFonts.weakPassword)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context,appFonts.weekPassword),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))));
        } else if (e.code == language(context,appFonts.emailAlreadyInUse)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context,appFonts.emailHasAlready),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))));
        }
      } catch (e) {
        hideLoading(context);
      }
    }
  }
}
