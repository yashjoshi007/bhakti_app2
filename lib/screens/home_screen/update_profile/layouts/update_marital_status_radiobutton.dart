import 'package:bhakti_app/config.dart';

class UpdateMaritalStatusBox extends StatelessWidget {
  const UpdateMaritalStatusBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context, appFonts.maritalStatus),
          color: updateProfilePvr.nameValid == null
              ? const Color(0xff541F5C).withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: Insets.i8,
          child: Row(children: [
            const HSpace(Insets.i18),
            SvgPicture.asset(eSvgAssets.wedding),
            const HSpace(Insets.i10),
            SvgPicture.asset(eSvgAssets.line),
            GestureDetector(
                onTap: () {
                  updateProfilePvr.maritalStatusChanged(1);
                },
                child: Row(children: [
                  Radio(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => appColor(context).appTheme.primary),
                      value: 1,
                      groupValue: updateProfilePvr.selectedMarital,
                      onChanged: (value) =>
                          updateProfilePvr.maritalStatusChanged(value)),
                  Text(language(context, appFonts.married),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText))
                ])),
            GestureDetector(
                onTap: () {
                  updateProfilePvr.maritalStatusChanged(2);
                },
                child: Row(children: [
                  Radio(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => appColor(context).appTheme.primary),
                      value: 2,
                      groupValue: updateProfilePvr.selectedMarital,
                      onChanged: (value) =>
                          updateProfilePvr.maritalStatusChanged(value)),
                  Text(language(context, appFonts.unmarried),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText))
                ]))
          ])).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
