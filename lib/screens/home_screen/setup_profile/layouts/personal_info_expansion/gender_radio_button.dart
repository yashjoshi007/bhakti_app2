import 'package:bhakti_app/config.dart';

class GenderRadioBox extends StatelessWidget {
  const GenderRadioBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          radius: AppRadius.r8,
          color: appColor(context).appTheme.primary.withOpacity(.20),
          width: double.infinity,
          title: language(context, appFonts.gender),
          child: Row(children: [
            const HSpace(Insets.i17),
            SvgPicture.asset(eSvgAssets.gender),
            const HSpace(Insets.i10),
            SvgPicture.asset(eSvgAssets.line,
                height: Sizes.s24, width: Sizes.s24),
            const HSpace(Insets.i5),
            Radio(
              fillColor: MaterialStateColor.resolveWith(
                  (states) => appColor(context).appTheme.primary),
              value: 1,
              groupValue: profilePvr.selectedGender,
              onChanged: (value) => profilePvr.maleGender(value),
            ),
            Text(language(context, appFonts.male),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.primary)),
            Radio(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => appColor(context).appTheme.primary),
                value: 2,
                groupValue: profilePvr.selectedGender,
                onChanged: (value) => profilePvr.femaleGender(value)),
            Text(language(context, appFonts.female),
                style: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.primary))
          ])).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
