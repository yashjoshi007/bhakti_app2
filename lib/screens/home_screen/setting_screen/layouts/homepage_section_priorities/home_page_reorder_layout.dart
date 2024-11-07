import 'package:bhakti_app/config.dart';

class HomePageReorderLayout extends StatelessWidget {
  const HomePageReorderLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return ReorderableListView(
          children: [
            for (final tile in appArray.homePageSectionList)
              Padding(
                  key: ValueKey(tile),
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                      decoration: BoxDecoration(
                          color: appColor(context).appTheme.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0x1E929292),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                                spreadRadius: 0)
                          ]),
                      child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(language(context,tile['name']),
                              style: appCss.philosopherBold18.textColor(
                                  appColor(context).appTheme.rulesClr)),
                          leading: Container(
                              width: 20,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topLeft: Radius.circular(8)),
                                  color:
                                      appColor(context).appTheme.containColor),
                              child: SvgPicture.asset(tile['svgImage'])
                                  .paddingSymmetric(
                                      vertical: Sizes.s18,
                                      horizontal: Sizes.s4)),
                          trailing: SizedBox(
                              height: Sizes.s22,
                              width: Sizes.s41,
                              child: FlutterSwitch(
                                  width: Sizes.s41,
                                  height: Sizes.s23,
                                  padding: Sizes.s3,
                                  toggleSize: Sizes.s17,
                                  value: tile['isOn'],
                                  activeColor: appColor(context).appTheme.primary,
                                  inactiveColor: appColor(context).appTheme.lightText,
                                  borderRadius: AppRadius.r40,
                                  onToggle: (val) => settingPvr.onToggle(val, tile))).paddingSymmetric(horizontal: Sizes.s12))))
          ],
          onReorder: (oldIndex, newIndex) =>
              settingPvr.onReorder(oldIndex, newIndex));
    });
  }
}
