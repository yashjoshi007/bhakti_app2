import 'package:bhakti_app/config.dart';

class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({super.key});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<LoginAuthProvider, SettingProvider, AppLanguageProvider>(
        builder: (context, loginAuthPvr, settingPvr, appLanguagePvr, child) {
      return Scaffold(
          body: Container(
              height: double.infinity,
              padding: EdgeInsets.only(
                  bottom: Insets.i27,
                  top: MediaQuery.of(context).size.height * 0.13),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(eImageAssets.splashBg))),
              child: Stack(alignment: Alignment.topCenter, children: [
                SingleChildScrollView(
                    child: Column(children: [
                  Image.asset(eImageAssets.bhaktiLogo, height: Sizes.s63),
                  Text(language(context, appFonts.sadhanaRecord),
                      style: appCss.philosopherBold25),
                  VSpace(MediaQuery.of(context).size.height * 0.2),
                  ...loginAuthPvr.buildAuthButtons(context),
                  const VSpace(Insets.i40),
                  const LanguageSelection()
                ]).paddingSymmetric(horizontal: Insets.i20)),
                Text(language(context, appFonts.aNewAccount))
                    .alignment(Alignment.bottomCenter)
              ])));
    });
  }
}
