import 'package:bhakti_app/config.dart';

class UpdateInitiatedNameTextBox extends StatelessWidget {
  const UpdateInitiatedNameTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
        height: Sizes.s52,
        width: double.infinity,
        color: updateProfilePvr.initiatedNameValid == null
            ? appColor(context).appTheme.primary.withOpacity(.20)
            : appColor(context).appTheme.red,
        title: language(context,appFonts.initiatedName),
        radius: AppRadius.r8,
        child: TextFieldCommon(
            validator: (value) =>
                updateProfilePvr.initiatedNameValidator(value),
            controller: updateProfilePvr.initiatedName,
            hintText: language(context,appFonts.initiatedName),
            prefixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const HSpace(Insets.i18),
                  SvgPicture.asset(eSvgAssets.userInitiated, height: Sizes.s20),
                  const HSpace(Insets.i12),
                  SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                  const HSpace(Insets.i20)
                ])),
      ).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
