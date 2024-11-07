import 'package:bhakti_app/config.dart';

class InitiatedNameTextBox extends StatelessWidget {
  const InitiatedNameTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          color: profilePvr.initiatedNameValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          title: language(context, appFonts.initiatedName),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: (value) => profilePvr.initiatedNameValidator(value),
              controller: profilePvr.initiatedName,
              hintText: language(context, appFonts.initiatedName),
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i18),
                    SvgPicture.asset(eSvgAssets.userInitiated,
                        height: Sizes.s20),
                    const HSpace(Insets.i12),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
