import 'package:bhakti_app/config.dart';

class SettingDialogLayout extends StatelessWidget {
  const SettingDialogLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(language(context,appFonts.bhaktiStepsAccessKey),
                    textAlign: TextAlign.center,
                    style: appCss.philosopherBold18
                        .textColor(appColor(context).appTheme.primary)),
                const VSpace(Insets.i10),
                Text(language(context,appFonts.bhaktiStepsApplication),
                    textAlign: TextAlign.center,
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.rulesClr)),
                const VSpace(Insets.i25),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Container(
                              padding: const EdgeInsets.all(AppRadius.r4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      appColor(context).appTheme.textFieldClr,
                                  border: Border.all(
                                      color: appColor(context)
                                          .appTheme
                                          .primary
                                          .withOpacity(0.20)),
                                  borderRadius: BorderRadius.circular(8)),
                              height: Sizes.s50,
                              child: Text(language(context,settingPvr.bhakti!),style: appCss.dmDenseRegular14
                                  .textColor(appColor(context).appTheme.primary)))
                          .inkWell(onTap: () {
                    Clipboard.setData(ClipboardData(text: settingPvr.bhakti!));
                  })),
                  const HSpace(Insets.i10),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: language(context,settingPvr.bhakti!)));
                      },
                      child: AccessKeyContainer(
                          svgImage: eSvgAssets.documentCopy)),
                  const HSpace(Insets.i10),
                  GestureDetector(
                      child: AccessKeyContainer(
                          svgImage: eSvgAssets.shareMySadhana),
                      onTap: () {
                        Share.share(settingPvr.shareTemplate!
                            .replaceAll('{{bhakti_steps_access_key}}', settingPvr.bhakti!)
                            .replaceAll('{{name}}', settingPvr.bhaktiUserName!),
                            subject: language(context,appFonts.bhaktiStepsAccessKey));
                      })
                ])
              ]).paddingSymmetric(vertical: Sizes.s20, horizontal: Sizes.s15));
    });
  }
}
