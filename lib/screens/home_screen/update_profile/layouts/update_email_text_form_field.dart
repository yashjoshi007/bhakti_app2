import 'package:bhakti_app/config.dart';

class UpdateEmailTextBox extends StatelessWidget {
  const UpdateEmailTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context,appFonts.email),
          color: updateProfilePvr.emailValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: AppRadius.r8,
          child: TextFieldCommon(onChanged: (value) =>  updateProfilePvr.validateEmail(value, context),
              validator: (value) => updateProfilePvr.emailValidator(value,context),
              keyboardType: TextInputType.emailAddress,
              hintText: language(context,appFonts.email),
              controller: updateProfilePvr.emailId,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i20),
                    SvgPicture.asset(eSvgAssets.emailId, height: Sizes.s20),
                    const HSpace(Insets.i10),
                    SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
