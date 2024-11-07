import 'package:bhakti_app/config.dart';

class ContactInfoExpansionTile extends StatelessWidget {
  const ContactInfoExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context1, setUpProfilePvr, child) {
      return ExpansionTile(
          onExpansionChanged: (value) =>
              setUpProfilePvr.onContactInfoExpansionChanged(),
          tilePadding: EdgeInsets.zero,
          trailing: SvgPicture.asset(setUpProfilePvr.onChange1 == false
              ? eSvgAssets.arrowDown1
              : eSvgAssets.arrowUp),
          leading: Text(language(context,appFonts.contactInfo),
              style: appCss.philosopherBold18
                  .textColor(appColor(context).appTheme.lightText)),
          title: SvgPicture.asset(eSvgAssets.profileLine,
                  width: Sizes.s200, fit: BoxFit.fill)
              .paddingOnly(top: Insets.i5),
          children: const <Widget>[
            PhoneNumberTextBox(),
            VSpace(Insets.i18),
            CountryDropDownBox(),
            VSpace(Insets.i18),
            StateTextFieldBox(),
            VSpace(Insets.i18),
            CityTextFieldBox()
          ]);
    });
  }
}
