import 'package:bhakti_app/config.dart';

class SignUpLayout extends StatelessWidget {
  const SignUpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailSignUpProvider>(
        builder: (context, emailSignUpPvr, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VSpace(Insets.i40),
        Center(child: Image.asset(eImageAssets.bhaktiLogo, height: Sizes.s63)),
        const VSpace(Insets.i50),
        Text(language(context,appFonts.signUpHere1),
            style: appCss.philosopherBold28
                .textColor(appColor(context).appTheme.oneText)),
        Text(language(context,appFonts.enterYourDetailsBelow),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.threeText)),
        const VSpace(Insets.i30),
        EmailLoginWidget().commonEmailTextField(
            context,
            emailSignUpPvr,
            emailSignUpPvr.emailId,
            (value) => emailSignUpPvr.emailTextField(value,context)),
        const VSpace(Insets.i20),
        EmailLoginWidget().commonPasswordTextField(
            context,
            emailSignUpPvr,
            emailSignUpPvr.isHide ? true : false,
            Padding(
                    padding: const EdgeInsets.all(Insets.i10),
                    child: emailSignUpPvr.isHide
                        ? SvgPicture.asset(eSvgAssets.hideEye)
                        : SvgPicture.asset(eSvgAssets.eye,
                            colorFilter: ColorFilter.mode(
                                appColor(context).appTheme.primary,
                                BlendMode.srcIn)))
                .inkWell(onTap: () => emailSignUpPvr.isShowPassword()),
            (value) => emailSignUpPvr.passwordTextField(value, context),
            emailSignUpPvr.password),
        const VSpace(Insets.i25),
        CommonButton(
            text: language(context,appFonts.signUp),
            width: Sizes.s141,
            onTap: () => emailSignUpPvr.emailSignupNavigate(context)).center()
      ]);
    });
  }
}
