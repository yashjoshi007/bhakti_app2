import 'package:bhakti_app/config.dart';

class UpdateYatraNameTextBox extends StatelessWidget {
  const UpdateYatraNameTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context,appFonts.yatraName),
          color: updateProfilePvr.yatraNameValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: AppRadius.r8,
          child: TextFieldCommon(
              controller: updateProfilePvr.yatraName,
              validator: (value) => updateProfilePvr.yatraNameValidator(value),
              hintText:language(context,appFonts.yatraName),
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Sizes.s20),
                    SvgPicture.asset(eSvgAssets.call1, height: Sizes.s20),
                    const HSpace(Sizes.s12),
                    SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Sizes.s20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
