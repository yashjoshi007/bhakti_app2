import 'package:bhakti_app/config.dart';

class EmailTextBox extends StatelessWidget {
  const EmailTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return CustomTitleWidget(
        height: Sizes.s52,
        width: double.infinity,
        title: language(context,appFonts.email),
        color: profilePvr.emailValid == null
            ? appColor(context).appTheme.primary.withOpacity(.20)
            : appColor(context).appTheme.red,
        radius: AppRadius.r8,
        child: TextFieldCommon(onChanged: (value) =>  profilePvr.validateEmail(value, context),
            validator: (value) => profilePvr.emailValidator(value,context),
            keyboardType: TextInputType.emailAddress,
            hintText: language(context,appFonts.email),
            controller: profilePvr.emailId,
            prefixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const HSpace(Insets.i20),
                  SvgPicture.asset(eSvgAssets.emailId, height: Sizes.s20),
                  const HSpace(Insets.i10),
                  SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                  const HSpace(Insets.i20)
                ]))
      ).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
