import 'package:bhakti_app/config.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailLoginProvider>(
        builder: (context, emailLoginPvr, child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const VSpace(Insets.i40),
        Center(child: Image.asset(eImageAssets.bhaktiLogo, height: Sizes.s63)),
        const VSpace(Insets.i50),
        Text(language(context, appFonts.loginHere1),
            style: appCss.philosopherBold28
                .textColor(appColor(context).appTheme.oneText)),
        Text(language(context, appFonts.enterYourDetail),
            style: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.threeText)),
        const VSpace(Insets.i30),
        EmailLoginWidget().commonEmailTextField(
            context,
            emailLoginPvr,
            emailLoginPvr.emailId,
            (value) => emailLoginPvr.emailValidator(value, context)),
        const VSpace(Insets.i20),
        EmailLoginWidget().commonPasswordTextField(
            context,
            emailLoginPvr,
            emailLoginPvr.isHide ? true : false,
            Padding(
                    padding: const EdgeInsets.all(Insets.i10),
                    child: emailLoginPvr.isHide
                        ? SvgPicture.asset(eSvgAssets.hideEye)
                        : SvgPicture.asset(eSvgAssets.eye,
                            colorFilter: ColorFilter.mode(
                                appColor(context).appTheme.primary,
                                BlendMode.srcIn)))
                .inkWell(onTap: () => emailLoginPvr.isPasswordHide()),
            (value) => emailLoginPvr.passwordValidator(value, context),
            emailLoginPvr.password),
        const VSpace(Insets.i8),
        TextButton(
                onPressed: () => emailLoginPvr.forgotPassword(),
                child: Text(language(context, appFonts.forgotPassword),
                    style: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.primary),
                    textAlign: TextAlign.end))
            .alignment(Alignment.centerRight),
        const VSpace(Insets.i25),
        CommonButton(
                onTap: () => emailLoginPvr.loginButton(context),
                text: language(context, appFonts.login),
                width: Sizes.s141)
            .center()
      ]);
    });
  }
}
