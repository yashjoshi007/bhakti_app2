import 'package:bhakti_app/common/common_path_list.dart';
import 'package:bhakti_app/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashScreenProvider>(
        builder: (context, splashScreenPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(seconds: 3),
              () => splashScreenPvr.checkLocalData(context)),
          child: Scaffold(
              body: Container(
            padding: const EdgeInsets.only(bottom: Insets.i27),
            child: Center(
              child: Image.asset(eImageAssets.sadhanaLogo,
                  fit: BoxFit.cover, height: Sizes.s360),
            ),
            // child: Stack(alignment: Alignment.bottomCenter, children: [
            //   Center(
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            // Center(
            //     child: Image.asset(eImageAssets.bhaktiImg,
            //         fit: BoxFit.cover, height: Sizes.s265)),
            //         const VSpace(Insets.i55),
            //         Image.asset(eImageAssets.bhaktiLogo,
            //             height: Sizes.s70),
            //         const VSpace(Insets.i8),
            //         Text(language(context, appFonts.sadhanaSheet),
            //             style: appCss.philosopherBold28
            //                 .textColor(
            //                     appColor(context).appTheme.splashTxtClr)
            //                 .letterSpace(6))
            //       ])),
            //   Text(language(context, appFonts.copyRight),
            //       style: appCss.dmDenseSemiBold14
            //           .textColor(appColor(context).appTheme.lightText))
            // ])
          )));
    });
  }
}
