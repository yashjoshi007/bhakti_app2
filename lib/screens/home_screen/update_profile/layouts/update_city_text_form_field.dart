import 'package:bhakti_app/config.dart';

class UpdateCityTextFieldBox extends StatelessWidget {
  const UpdateCityTextFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          color: updateProfilePvr.cityValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          title: language(context,appFonts.city),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              controller: updateProfilePvr.city,
              validator: (value) => updateProfilePvr.cityTextField(value),
              hintText: language(context,appFonts.city),
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i14),
                    SvgPicture.asset(eSvgAssets.location, height: Sizes.s25),
                    const HSpace(Insets.i12),
                    SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20),
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
