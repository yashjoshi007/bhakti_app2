import '../config.dart';

class SocialLoginLayout extends StatelessWidget {
  const SocialLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<EmailLoginProvider, LoginAuthProvider>(
        builder: (context, emailLoginPvr, loginAuthPvr, child) {
      bool isIOS = Platform.isIOS;

      return Column(children: [
        const VSpace(Insets.i28),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(eSvgAssets.line11),
          const HSpace(Insets.i8),
          Text(language(context, appFonts.or), style: appCss.dmDenseMedium12),
          const HSpace(Insets.i8),
          SvgPicture.asset(eSvgAssets.line11)
        ]),
        const VSpace(Insets.i20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          EmailLoginWidget()
              .commonSocialContainer(context, eSvgAssets.call)
              .inkWell(onTap: () => emailLoginPvr.phoneLoginNavigate(context)),
          const HSpace(Insets.i15),
          EmailLoginWidget().commonSocialContainer(context, eSvgAssets.fb),
          const HSpace(Insets.i15),
          EmailLoginWidget()
              .commonSocialContainer(context, eSvgAssets.google)
              .inkWell(onTap: () => loginAuthPvr.signInWithGoogle(context)),
          if (isIOS) // Show Apple login only on iOS
            ...[
            const HSpace(Insets.i15),
            EmailLoginWidget()
                .commonSocialContainer(context, eSvgAssets.apple)
                .inkWell(onTap: () => loginAuthPvr.signInWithApple())
          ]
        ])
      ]);
    });
  }
}
