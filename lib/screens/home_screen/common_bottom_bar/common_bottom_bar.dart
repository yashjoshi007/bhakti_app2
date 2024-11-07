import 'package:bhakti_app/config.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  const CommonBottomNavigationBar({super.key});

  @override
  State<CommonBottomNavigationBar> createState() =>
      _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomNavProvider, HomeScreenProvider>(
        builder: (context, bottomNavPrv, homeScreenPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 50),
              () => bottomNavPrv.onInit(this)),
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) =>
                      homeScreenPvr.showExitPopup(context),
                  child: Scaffold(
                      key: homeScreenPvr.homeScreenKey,
                      drawer: const DrawerScreen(),
                      body: bottomNavPrv.dashList.isEmpty
                          ? Container()
                          : DefaultTabController(
                              length: bottomNavPrv.dashList.length,
                              child: Scaffold(
                                  body: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: bottomNavPrv.tabController,
                                      children: bottomNavPrv.screens),
                                  bottomNavigationBar: const BottomNavBar(),
                                  backgroundColor:
                                      appColor(context).appTheme.primary))))));
    });
  }
}
