import 'package:bhakti_app/config.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<EmailSignUpProvider, LoginAuthProvider,
            EmailLoginProvider>(
        builder:
            (context1, emailSignUpPvr, loginAuthPvr, emailLoginPvr, child) {
      return LoadingComponent(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: EmailLoginWidget().commonBgDecoration(
                  context,
                  Stack(children: [
                    Form(
                        key: emailSignUpPvr.signUpFormKey,
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SignUpLayout(),
                              SocialLoginLayout()
                            ]).paddingSymmetric(horizontal: Insets.i20)),
                    EmailLoginWidget().commonRichText(
                        context,
                        language(context, appFonts.alreadyHaveAccount),
                        language(context, appFonts.loginHere),
                        () => emailSignUpPvr.alreadyAccountNavigate(context))
                  ]))));
    });
  }
}
