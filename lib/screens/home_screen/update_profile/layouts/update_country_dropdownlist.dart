import 'package:bhakti_app/config.dart';
import 'package:dropdown_search/dropdown_search.dart';

class UpdateCountryDropDownBox extends StatelessWidget {
  const UpdateCountryDropDownBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context1, updateProfilePvr, child) {
      return updateProfilePvr.countryItems.isNotEmpty
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
                          child: DropdownSearch<dynamic>(
                              items: updateProfilePvr.countryItems,
                              itemAsString: (item) =>
                                  language(context, item["name"]),
                              selectedItem: updateProfilePvr.countrySelected,
                              onChanged: (value) {
                                updateProfilePvr.selectCountry(value);
                              },
                              dropdownButtonProps:
                                  const DropdownButtonProps(isVisible: false),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                  baseStyle: appCss.dmDenseExtraBold16
                                      .textColor(const Color(0xff767676)),
                                  dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      counterText: '',
                                      errorMaxLines: 1,
                                      errorStyle: TextStyle(
                                          fontSize: 0,
                                          color: appColor(context)
                                              .appTheme
                                              .primary),
                                      disabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(AppRadius.r8)),
                                          borderSide: BorderSide.none),
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(AppRadius.r8)),
                                          borderSide: BorderSide.none),
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(AppRadius.r8)),
                                          borderSide: BorderSide.none),
                                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)), borderSide: BorderSide.none),
                                      contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s14, horizontal: Sizes.s15),
                                      hintText: appFonts.search,
                                      hintStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText),
                                      labelStyle: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText))),
                              popupProps: PopupProps.menu(
                                  itemBuilder: (context, item, isSelected) {
                                    return ListTile(
                                        title: Text(
                                            language(context, item["name"]),
                                            style: appCss.dmDenseMedium14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .lightText)));
                                  },
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(decoration: InputDecoration(filled: true, fillColor: appColor(context).appTheme.primary.withOpacity(0.1), enabled: true, counterText: '', errorMaxLines: 1, errorStyle: TextStyle(fontSize: 0, color: appColor(context).appTheme.primary), disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)), borderSide: BorderSide.none), focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)), borderSide: BorderSide.none), enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)), borderSide: BorderSide.none), border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s17, horizontal: Sizes.s15), hintText: appFonts.search, hintStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText), labelStyle: appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText))))))
                    ])),
                    SvgPicture.asset(eSvgAssets.arrowDown)
                        .marginSymmetric(horizontal: Insets.i20)
                  ])).paddingSymmetric(vertical: Sizes.s10)
          : Container();
    });
  }
}
