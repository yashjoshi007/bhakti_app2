import 'package:bhakti_app/config.dart';

class PhoneLoginWidget {
  Widget buildLogoAndText(context) {
    return Column(children: [
      Image.asset(eImageAssets.bhaktiLogo,
          height: Sizes.s63, width: Sizes.s267),
      Text(language(context, appFonts.sadhanaRecord),
          style: appCss.philosopherBold25)
    ]);
  }

  Widget buildPhoneNumberInput(
      PhoneLoginProvider phoneLoginPvr, BuildContext context) {
    return IntlPhoneField(
            onChanged: (value) => phoneLoginPvr.countryCodeChange(value),
            showDropdownIcon: false,
            flagsButtonMargin: const EdgeInsets.only(left: 10),
            autofocus: true,
            pickerDialogStyle: buildPickerDialogStyle(context),
            invalidNumberMessage:
                language(context, appFonts.pleaseEnterValidPhoneNumber),
            validator: (p0) => phoneLoginPvr.validator(p0, context),
            focusNode: phoneLoginPvr.focusNode,
            controller: phoneLoginPvr.phoneNumber,
            keyboardType: TextInputType.number,
            decoration: buildInputDecoration(context),
            style: buildInputTextStyle(context),
            initialCountryCode: language(context, appFonts.us))
        .paddingSymmetric(horizontal: Insets.i20);
  }

  PickerDialogStyle buildPickerDialogStyle(BuildContext context) {
    return PickerDialogStyle(
        countryNameStyle:
            appCss.dmDenseRegular16.textColor(appColor(context).appTheme.black),
        countryCodeStyle:
            appCss.dmDenseRegular16.textColor(appColor(context).appTheme.black),
        padding: const EdgeInsets.all(Insets.i20),
        searchFieldInputDecoration: InputDecoration(
            hintStyle: appCss.dmDenseExtraBold16
                .textColor(appColor(context).appTheme.lightText),
            counterText: "",
            hintText: language(context, appFonts.search),
            border: OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.r10)),
                borderSide: BorderSide(
                    color:
                        appColor(context).appTheme.primary.withOpacity(0.20))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        appColor(context).appTheme.primary.withOpacity(0.20)),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.r10))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        appColor(context).appTheme.primary.withOpacity(0.20)),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.r10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColor(context).appTheme.primary.withOpacity(0.20),
                ),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadius.r10)))));
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
        hintStyle: appCss.dmDenseExtraBold16
            .textColor(appColor(context).appTheme.primary.withOpacity(0.20)),
        counterText: "",
        hintText: language(context, appFonts.phoneNumber),
        label: Text(language(context, appFonts.phoneNumber),
            style: appCss.dmDenseExtraBold16
                .textColor(appColor(context).appTheme.lightText)),
        border: OutlineInputBorder(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10)),
            borderSide: BorderSide(
                color: appColor(context).appTheme.primary.withOpacity(0.20))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: appColor(context).appTheme.primary.withOpacity(0.20)),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: appColor(context).appTheme.primary.withOpacity(0.20)),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: appColor(context).appTheme.primary.withOpacity(0.20)),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r10))));
  }

  TextStyle buildInputTextStyle(BuildContext context) {
    return appCss.dmDenseExtraBold16
        .textColor(appColor(context).appTheme.lightText);
  }
}
