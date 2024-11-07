import 'package:bhakti_app/config.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmailLoginProvider>(
        builder: (context1, emailLoginPvr, child) {
      return Stack(alignment: Alignment.center, children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: EmailLoginWidget().commonBgDecoration(
                context,
                Stack(children: [
                  Form(
                      key: emailLoginPvr.emailFormKey,
                      child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [LoginLayout(), SocialLoginLayout()])
                          .paddingSymmetric(horizontal: Insets.i20)),
                  EmailLoginWidget().commonRichText(
                      context,
                      language(context, appFonts.doNotHaveAccount),
                      language(context, appFonts.signUpHere),
                      () => emailLoginPvr.signUpNavigate(context))
                ]))),
        if (emailLoginPvr.isLoading) const CircularProgressIndicator()
      ]);
    });
  }
}
