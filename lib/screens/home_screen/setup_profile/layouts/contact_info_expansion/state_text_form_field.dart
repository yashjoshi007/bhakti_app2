import 'package:bhakti_app/config.dart';

class StateTextFieldBox extends StatelessWidget {
  const StateTextFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context,appFonts.state),
          radius: AppRadius.r8,
          color: profilePvr.stateValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          child: TextFieldCommon(
              controller: profilePvr.state,
              validator: (value) => profilePvr.stateValidator(value),
              hintText: language(context,appFonts.state),
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i14),
                    SvgPicture.asset(eSvgAssets.map, height: Sizes.s25),
                    const HSpace(Insets.i12),
                    SvgPicture.asset(eSvgAssets.line, height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
