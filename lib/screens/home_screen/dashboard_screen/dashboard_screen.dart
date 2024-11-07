import 'package:bhakti_app/config.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<DashboardProvider, SettingProvider>(
        builder: (context1, dashboardPvr, settingPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(seconds: 1),
              () => dashboardPvr.onInit(context)),
          child: Stack(children: [
            SafeArea(
                child: Scaffold(
                    extendBodyBehindAppBar: true,
                    extendBody: true,
                    body:
                        DashboardWidget().buildDashboardBody(context))),
            if (dashboardPvr.isLoading) const CommonLoading()
          ]));
    });
  }
}
