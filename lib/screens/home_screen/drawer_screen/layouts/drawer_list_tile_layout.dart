import 'package:bhakti_app/config.dart';

class DrawerListTileLayout extends StatelessWidget {
  final dynamic data;
  final List? aboutUsList, bhaktiCertificationList;
  final GestureTapCallback? drawerOnTap;
  final int? index, selectedIndex;
  final bool? isExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  const DrawerListTileLayout(
      {super.key,
      this.data,
      this.aboutUsList,
      this.drawerOnTap,
      this.index,
      this.selectedIndex,
      this.bhaktiCertificationList,
      this.isExpanded,
      this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context1, homeScreenPvr, child) {
      return ListTile(
              minVerticalPadding: 1,
              contentPadding: EdgeInsets.zero,
              dense: true,
              onTap: () =>
                  homeScreenPvr.homeScreenKey.currentState!.closeDrawer(),
              title: language(context, data['name']) ==
                          language(context, appFonts.aboutUs) ||
                      language(context, data['name']) ==
                          language(context, appFonts.bhaktiStepsCertifications)
                  ? CustomExpansionTile(
                      isExpanded: isExpanded,
                      onExpansionChanged: onExpansionChanged,
                      svgIcon: data['icon'],
                      title: language(context, data['name']) ==
                              language(context, appFonts.aboutUs)
                          ? language(context, appFonts.aboutUs)
                          : language(
                              context, appFonts.bhaktiStepsCertifications),
                      children: language(context, data['name']) ==
                              language(context, appFonts.aboutUs)
                          ? aboutUsList!
                              .asMap()
                              .entries
                              .map((aboutUsName) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  onTap: () =>
                                      homeScreenPvr.aboutUsExpansionTileOnTap(
                                          aboutUsName, context),
                                  title: Row(children: [
                                    const HSpace(Insets.i30),
                                    SvgPicture.asset(aboutUsName.value['icon']),
                                    const HSpace(Insets.i10),
                                    Text(
                                        language(
                                            context, aboutUsName.value['name']),
                                        style: appCss.dmDenseRegular16
                                            .textColor(appColor(context)
                                                .appTheme
                                                .lightText))
                                  ])))
                              .toList()
                          : bhaktiCertificationList!
                              .asMap()
                              .entries
                              .map((certificationListName) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  onTap: () => homeScreenPvr
                                      .certificateExpansionTileOnTap(
                                          certificationListName, context),
                                  title: Row(children: [
                                    const HSpace(Insets.i30),
                                    SvgPicture.asset(
                                        certificationListName.value['icon']),
                                    const HSpace(Insets.i10),
                                    Text(
                                        language(
                                            context,
                                            certificationListName
                                                .value['name']),
                                        style: appCss.dmDenseRegular16
                                            .textColor(appColor(context)
                                                .appTheme
                                                .lightText))
                                  ])))
                              .toList())
                  : Row(children: [
                      const HSpace(Insets.i10),
                      SvgPicture.asset(homeScreenPvr.isExpanded
                          ? data['icon']
                          : selectedIndex == index
                              ? data['fillIcon']
                              : data['icon']),
                      const HSpace(Insets.i10),
                      Text(language(context, data['name']),
                          style: appCss.dmDenseRegular16
                              .textColor(homeScreenPvr.isExpanded
                                  ? appColor(context).appTheme.lightText
                                  : selectedIndex == index
                                      ? appColor(context).appTheme.primary
                                      : appColor(context).appTheme.lightText))
                    ]).inkWell(onTap: drawerOnTap))
          .decorated(
              gradient: LinearGradient(
                  colors: homeScreenPvr.isExpanded
                      ? [appColor(context).appTheme.trans, appColor(context).appTheme.trans]
                      : selectedIndex == index
                          ? [
                              appColor(context)
                                  .appTheme
                                  .primary
                                  .withOpacity(0.3),
                              appColor(context)
                                  .appTheme
                                  .primary
                                  .withOpacity(0.05)
                            ]
                          : [appColor(context).appTheme.trans, appColor(context).appTheme.trans]));
    });
  }
}
