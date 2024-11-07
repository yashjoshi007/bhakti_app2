import 'package:bhakti_app/config.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<bool> isTileExpandedList =
      List.filled(appArray.drawerList.length, false);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return SafeArea(
          child: Drawer(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const VSpace(Insets.i40),
              Image.asset(eImageAssets.bhaktiLogo)
                  .marginSymmetric(horizontal: 55),
              const VSpace(Insets.i30)
            ]),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              ...appArray.drawerList.asMap().entries.map((e) {
                List bhaktiCertificationList = [];
                if (language(context, e.value['name']) ==
                    language(context, appFonts.bhaktiStepsCertifications)) {
                  bhaktiCertificationList = e.value['list'];
                }

                List aboutUsList = [];
                if (language(context, e.value['name']) ==
                    language(context, appFonts.aboutUs)) {
                  aboutUsList = e.value['list'];
                }
                return DrawerListTileLayout(
                    isExpanded: isTileExpandedList[e.key],
                    onExpansionChanged: (isExpanded) {
                      homeScreenPvr.notifyListeners();
                      isTileExpandedList[e.key] = isExpanded;
                    },
                    index: e.key,
                    selectedIndex: homeScreenPvr.selectedIndex,
                    drawerOnTap: () =>
                        homeScreenPvr.onTapDrawer(e.key, e.value, context),
                    data: e.value,
                    aboutUsList: aboutUsList,
                    bhaktiCertificationList: bhaktiCertificationList);
              })
            ]))),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                    "${language(context, appFonts.version)} ${homeScreenPvr.appVersion}",
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.lightText)),
                Text(
                    "${language(context, appFonts.id)} ${homeScreenPvr.loggedInId ?? homeScreenPvr.userModel!.id}",
                    style: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.lightText))
              ]),
              const VSpace(Insets.i8),
              SvgPicture.asset(eSvgAssets.profileLine, width: Sizes.s224),
              const VSpace(Insets.i19),
              Row(children: [
                const HSpace(Insets.i20),
                SvgPicture.asset(eSvgAssets.logOut),
                const HSpace(Insets.i10),
                Text(language(context, appFonts.logOut),
                    style: appCss.dmDenseRegular16
                        .textColor(appColor(context).appTheme.lightText))
              ]).inkWell(onTap: () {
                homeScreenPvr.homeScreenKey.currentState!.closeDrawer();
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: SizedBox(
                              height: 175,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                            language(context, appFonts.logOut),
                                            style: appCss.philosopherBold18
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .primary))),
                                    const VSpace(Insets.i10),
                                    Center(
                                        child: Text(
                                            language(
                                                context,
                                                appFonts
                                                    .areYouSureYouWantToLogOut),
                                            style: appCss.dmDenseRegular14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .rulesClr))),
                                    const VSpace(Insets.i25),
                                    CommonSelectionButton(
                                        textOne: language(context, appFonts.no),
                                        textTwo:
                                            language(context, appFonts.yes),
                                        onTapOne: () => Navigator.pop(context),
                                        onTapTwo: () => homeScreenPvr
                                            .onSignOutClick(context))
                                  ])));
                    });
              })
            ]).paddingOnly(top: 20, bottom: 20)
          ])));
    });
  }
}
