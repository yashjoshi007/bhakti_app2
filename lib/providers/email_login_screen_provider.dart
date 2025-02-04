import 'package:bhakti_app/config.dart';

class EmailLoginProvider extends ChangeNotifier {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false, isValid = false, isHide = true;
  SharedPreferences? preferences;
  // final GlobalKey<ScaffoldState> emailScaffoldKey = GlobalKey<ScaffoldState>();
  bool value = false;
  String? passwordValid, emailValid;
  final emailFormKey = GlobalKey<FormState>();

  // Validates the email field and displays appropriate error messages
  emailValidator(value, context) {
    notifyListeners();
    if (value!.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      emailValid = language(context, appFonts.enterValidEmail);
      return language(context, appFonts.enterValidEmail);
    } else {
      emailValid = null;
      return null;
    }
  }

  // Navigates to the sign-up screen
  signUpNavigate(context) {
    Navigator.pushNamed(context, routeName.emailSignUpScreen);
  }

  // Navigates to the phone login screen
  phoneLoginNavigate(context) =>
      Navigator.pushNamed(context, routeName.phoneLoginScreen);

  // Validates the password field and displays appropriate error messages
  passwordValidator(value, context) {
    notifyListeners();
    if (value!.isEmpty ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
      value.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context, appFonts.enterPassword),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context, appFonts.enterValidPassword),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))));
      passwordValid = language(context, appFonts.enterValidEmail);
      return language(context, appFonts.enterAValidPassword);
    } else {
      passwordValid = null;
      return null;
    }
  }

  // Toggles the visibility of the password field
  isPasswordHide() {
    notifyListeners();
    isHide = !isHide;
  }

  // Initiates the process for resetting the user's password
  forgotPassword() {}

  // Handles the login process and navigates to the appropriate screen
  loginButton(context) async {
    if (emailFormKey.currentState!.validate()) {
      notifyListeners();
      try {
        isLoading = true;
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailId.text, password: password.text);

        String? token = await credential.user!.getIdToken();

        final commonApi =
            Provider.of<CommonApiProvider>(context, listen: false);

        await commonApi.socialLogin(context, token);

        isValid = false;
        notifyListeners();
        preferences = await SharedPreferences.getInstance();
        UserModel? userModel;

        await Future.delayed(DurationsClass.s2);
        userModel = UserModel.fromJson(
            json.decode(preferences!.getString(session.user)!));
        debugPrint("userModel ${userModel.name}");
        isLoading = false;
        notifyListeners();
        if (userModel.name == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const SetUpProfile();
          }));
          emailId.text = "";
          password.text = "";
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(providers: [
                        ChangeNotifierProvider(
                            create: (_) => BottomNavProvider())
                      ], child: const CommonBottomNavigationBar())),
              ModalRoute.withName(routeName.commonBottomNavigationBar));
          emailId.text = "";
          password.text = "";
        }
        // ignore: use_build_context_synchronously
      } on FirebaseAuthException catch (e) {
        if (e.code == language(context, appFonts.userNotFound)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(language(context, appFonts.noUserFound),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))));
        } else if (e.code == language(context, appFonts.wrongPassword)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(language(context, appFonts.wrongPasswordProvided),
                  style: appCss.dmDenseRegular16
                      .textColor(appColor(context).appTheme.primary))));
        }
        isValid = true;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      }
    }
    emailId.text = "";
    password.text = "";
  }
}
