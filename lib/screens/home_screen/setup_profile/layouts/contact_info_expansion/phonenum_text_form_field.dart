import 'package:bhakti_app/config.dart';

class PhoneNumberTextBox extends StatelessWidget {
  const PhoneNumberTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, setupProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          color: setupProfilePvr.phoneNumberValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          title: language(context, appFonts.phoneNumber),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: (value) => setupProfilePvr.phoneNumValidator(value),
              keyboardType: TextInputType.number,
              hintText: language(context, appFonts.phoneNumber),
              controller: setupProfilePvr.phoneNum,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i20),
                    CountryCodePicker(
                        showFlag: false,
                        searchDecoration: InputDecoration(
                            hintText: language(context, appFonts.search)),
                        padding: EdgeInsets.zero,
                        onChanged: (value) =>
                            setupProfilePvr.phoneOnChanged(value, context),
                        textStyle: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText),
                        dialogTextStyle: appCss.dmDenseMedium16,
                        initialSelection: 'IT',
                        favorite: const ['+91', 'भारत'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false),
                    const HSpace(Insets.i10),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
