import 'package:bhakti_app/config.dart';
import 'package:dropdown_search/dropdown_search.dart';

class UpdateSpiritualMasterBox extends StatelessWidget {
  const UpdateSpiritualMasterBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
          return CustomTitleWidget(
              radius: AppRadius.r8,
              height: Sizes.s52,
              width: double.infinity,
              color: appColor(context).appTheme.primary.withOpacity(.20),
              title: language(context, appFonts.spiritualMaster),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const HSpace(Insets.i15),
                SvgPicture.asset(eSvgAssets.profile, height: Sizes.s25),
                const HSpace(Insets.i8),
                SvgPicture.asset(eSvgAssets.line),
                const HSpace(Insets.i19),
                Expanded(
                    child: DropdownSearch<String>(
                        items: updateProfilePvr.items,
                        itemAsString: (item) => language(context, item),
                        selectedItem: updateProfilePvr.spiritualSelectedItems,
                        onChanged: (value) {
                          updateProfilePvr.spiritualOnChanged(value);
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
                                    fontSize: 0, color: appColor(context)
                                    .appTheme.primary),
                                disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(AppRadius.r8)),
                                    borderSide: BorderSide.none),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(AppRadius.r8)),
                                    borderSide: BorderSide.none),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(AppRadius.r8)),
                                    borderSide: BorderSide.none),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(AppRadius.r8)),
                                    borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: Sizes.s14,
                                    horizontal: Sizes.s15),
                                hintText: appFonts.search,
                                hintStyle: appCss.dmDenseMedium14
                                    .textColor(appColor(context).appTheme
                                    .lightText),
                                labelStyle: appCss.dmDenseRegular14
                                    .textColor(appColor(context).appTheme
                                    .lightText))),
                        popupProps: PopupProps.menu(
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                  title: Text(
                                      language(context, item),
                                      style: appCss.dmDenseMedium14
                                          .textColor(
                                          appColor(context).appTheme
                                              .lightText)));
                            },
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                    appColor(context).appTheme.primary
                                        .withOpacity(0.1),
                                    enabled: true,
                                    counterText: '',
                                    errorMaxLines: 1,
                                    errorStyle: TextStyle(
                                        fontSize: 0,
                                        color: appColor(context).appTheme
                                            .primary),
                                    disabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(AppRadius.r8)),
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(AppRadius.r8)),
                                        borderSide: BorderSide.none),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(AppRadius.r8)),
                                        borderSide: BorderSide.none),
                                    border: const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(AppRadius.r8)),
                                        borderSide: BorderSide.none),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: Sizes.s17,
                                        horizontal: Sizes.s15),
                                    hintText: appFonts.search,
                                    hintStyle: appCss.dmDenseMedium14
                                        .textColor(
                                        appColor(context).appTheme.lightText),
                                    labelStyle: appCss.dmDenseRegular14
                                        .textColor(
                                        appColor(context).appTheme
                                            .lightText)))))),
                SvgPicture.asset(eSvgAssets.arrowDown)
                    .marginSymmetric(horizontal: Insets.i20)
              ])).paddingSymmetric(vertical: Sizes.s10);
        });
  }
}
