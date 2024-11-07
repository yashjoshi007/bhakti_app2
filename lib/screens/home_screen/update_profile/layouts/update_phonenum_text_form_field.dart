import 'package:bhakti_app/config.dart';

class UpdatePhoneNumberTextBox extends StatelessWidget {
  const UpdatePhoneNumberTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context1, updateProfilePvr, child) {
      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          color: updateProfilePvr.phoneNumberValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          title: language(context, appFonts.phoneNumber),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: (value) =>
                  updateProfilePvr.phoneNumberValidator(value),
              keyboardType: TextInputType.number,
              hintText: language(context, appFonts.phoneNumber),
              controller: updateProfilePvr.phoneNum,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i20),
                    CountryCodePicker(
                        enabled: true,
                        searchStyle: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText),
                        textOverflow: TextOverflow.fade,
                        showFlag: true,
                        searchDecoration: InputDecoration(
                            fillColor: appColor(context)
                                .appTheme
                                .primary
                                .withOpacity(0.2),
                            enabled: true,
                            filled: true,
                            errorStyle: TextStyle(
                                fontSize: 0,
                                color: appColor(context).appTheme.primary),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.r8)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.r8)),
                                borderSide: BorderSide.none),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.r8)),
                                borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: Sizes.s17, horizontal: Sizes.s15),
                            labelStyle: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText),
                            hintStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText),
                            hintText: language(context, appFonts.search)),
                        padding: EdgeInsets.zero,
                        onChanged: (value) => updateProfilePvr.countryCodeOnChanged(value),
                        textStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText),
                        dialogTextStyle: appCss.dmDenseMedium16,
                        initialSelection: "${updateProfilePvr.countryCode}",
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
