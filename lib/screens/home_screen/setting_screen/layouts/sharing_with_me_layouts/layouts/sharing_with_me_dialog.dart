import 'package:bhakti_app/config.dart';

class ShareWithMeDialog extends StatelessWidget {
  const ShareWithMeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
            height: Insets.i175,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const VSpace(Insets.i10),
              Text(language(context, appFonts.deleteUser),
                  style: appCss.philosopherBold18
                      .textColor(appColor(context).appTheme.primary)),
              const VSpace(Insets.i10),
              Text(language(context, appFonts.areYouSure),
                  style: appCss.dmDenseRegular14
                      .textColor(appColor(context).appTheme.rulesClr)),
              Text(language(context, appFonts.thisAction),
                  style: appCss.dmDenseRegular14
                      .textColor(appColor(context).appTheme.rulesClr)),
              const VSpace(Insets.i25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: Sizes.s1,
                                color: appColor(context).appTheme.primary),
                            borderRadius: BorderRadius.circular(8)),
                        height: Sizes.s44,
                        width: Sizes.s120,
                        child: Text(language(context, appFonts.cancel),
                            style: appCss.dmDenseMedium16
                                .textColor(appColor(context).appTheme.primary)))
                    .inkWell(onTap: () {
                  Navigator.pop(context);
                }),
                const HSpace(Insets.i15),
                Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appColor(context).appTheme.primary),
                        height: Sizes.s44,
                        width: Sizes.s120,
                        child: Text(language(context, appFonts.delete),
                            style: appCss.dmDenseMedium16.textColor(
                                appColor(context).appTheme.whiteColor)))
                    .inkWell(onTap: () {
                  Navigator.pop(context);
                })
              ])
            ])));
  }
}
