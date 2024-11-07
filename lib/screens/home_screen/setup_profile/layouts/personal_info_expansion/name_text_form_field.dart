import 'package:bhakti_app/config.dart';

class NameTextBox extends StatelessWidget {
  const NameTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          color: profilePvr.nameValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          width: double.infinity,
          title: language(context,appFonts.name1),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: (value) => profilePvr.nameValidator(value,context),
              hintText: language(context,appFonts.name),
              controller: profilePvr.name,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i20),
                    SvgPicture.asset(eSvgAssets.user, height: Sizes.s20),
                    const HSpace(Insets.i10),
                    SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
