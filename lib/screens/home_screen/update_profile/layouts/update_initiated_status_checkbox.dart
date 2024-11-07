import 'package:bhakti_app/config.dart';

class UpdateInitiatedStatusBox extends StatelessWidget {
  const UpdateInitiatedStatusBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          color: appColor(context).appTheme.primary.withOpacity(.20),
          radius: AppRadius.r8,
          title: language(context, appFonts.areYouInitiated),
          child: Row(children: [
            const HSpace(Insets.i16),
            SvgPicture.asset(eSvgAssets.frame),
            const HSpace(Sizes.s10),
            SvgPicture.asset(eSvgAssets.line),
            const HSpace(Sizes.s10),
            GestureDetector(
                onTap: () => updateProfilePvr.yesInitiated(true),
                child: Row(children: [
                  Radio(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => appColor(context).appTheme.primary),
                      value: true,
                      groupValue: updateProfilePvr.isInitiated,
                      onChanged: (value) =>
                          updateProfilePvr.yesInitiated(value)),
                  Text(language(context, appFonts.yes),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.primary))
                ])),
            const HSpace(Sizes.s20),
            GestureDetector(
                onTap: () => updateProfilePvr.noInitiated(false),
                child: Row(children: [
                  Radio(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => appColor(context).appTheme.primary),
                      value: false,
                      groupValue: updateProfilePvr.isInitiated,
                      onChanged: (value) =>
                          updateProfilePvr.noInitiated(value)),
                  Text(language(context, appFonts.no),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.primary))
                ]))
          ])).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
