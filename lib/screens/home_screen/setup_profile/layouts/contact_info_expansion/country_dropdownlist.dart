import 'package:bhakti_app/config.dart';

class CountryDropDownBox extends StatelessWidget {
  const CountryDropDownBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context1, profilePvr, child) {
      return profilePvr.countryItems.isNotEmpty
          ? CustomTitleWidget(
              radius: AppRadius.r8,
              height: Sizes.s52,
              width: double.infinity,
              color: appColor(context).appTheme.primary.withOpacity(.20),
              title: language(context, appFonts.country),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(children: [
                      const HSpace(Insets.i16),
                      SvgPicture.asset(eSvgAssets.global),
                      const HSpace(Insets.i10),
                      SvgPicture.asset(eSvgAssets.line,
                          height: Sizes.s24, width: Sizes.s24),
                      const HSpace(Insets.i20),
                      Expanded(
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          language(
                                              context, appFonts.selectCountry),
                                          style: TextStyle(
                                              color: appColor(context)
                                                  .appTheme
                                                  .lightText))),
                                  style: appCss.dmDenseMedium14.textColor(
                                      appColor(context).appTheme.lightText),
                                  isExpanded: true,
                                  icon: Container(),
                                  value: profilePvr.countrySelected,
                                  items: profilePvr.countryItems.map((e) {
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Text(language(context, e["name"]),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: appCss
                                                    .dmDenseExtraBold16
                                                    .textColor(
                                                        appColor(context)
                                                            .appTheme
                                                            .lightText))
                                            .width(Insets.i120));
                                  }).toList(),
                                  onChanged: (value) =>
                                      profilePvr.countryOnChanged(value))))
                    ])),
                    SvgPicture.asset(eSvgAssets.arrowDown)
                        .marginSymmetric(horizontal: Insets.i20)
                  ])).paddingSymmetric(vertical: Sizes.s10)
          : Container();
    });
  }
}
