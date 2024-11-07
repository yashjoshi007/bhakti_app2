import 'package:bhakti_app/customise/custom_week_calendar/custom_week_calendar1.dart';
import 'package:bhakti_app/config.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MonitoringProvider>(
        builder: (context1, monitoringPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 50),
              () => monitoringPvr.onInit(context)),
          child: SafeArea(
              child: Stack(children: [
            Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                    child: Column(children: [
                  CommonAppBar(
                          onTap: () => monitoringPvr.tabControl(context),
                          text: monitoringPvr.isAllSelected == true
                              ? language(context, appFonts.groupView)
                              : language(context, appFonts.userView),
                          hSpace: MediaQuery.of(context).size.width * 0.20)
                      .paddingSymmetric(horizontal: Insets.i20),
                  const VSpace(Insets.i10),
                  HorizontalWeekCalendar1(
                      datePickChange: monitoringPvr.selectedDate,
                      todayDate: DateTime.now(),
                      inactiveWeekColor: appColor(context).appTheme.rulesClr,
                      activeBackgroundColor: appColor(context).appTheme.primary,
                      activeTextColor: appColor(context).appTheme.whiteColor,
                      inactiveBackgroundColor:
                          appColor(context).appTheme.whiteColor,
                      inactiveDateColor: appColor(context).appTheme.lightText,
                      disabledTextColor: appColor(context).appTheme.lightText,
                      disabledBackgroundColor:
                          appColor(context).appTheme.whiteColor,
                      activeNavigatorColor:
                          appColor(context).appTheme.whiteColor,
                      inactiveNavigatorColor:
                          appColor(context).appTheme.whiteColor,
                      onDateChange: (date) => {
                            monitoringPvr.onCalendarDateChange(date, context)
                          }).paddingSymmetric(horizontal: Insets.i20),
                  const VSpace(Insets.i10),
                  CommonLeftSideText(
                          text: language(context, appFonts.sharingWithMe))
                      .paddingSymmetric(horizontal: Insets.i20),
                  const MonitoringGroupUpperLayout()
                ])))),
            if (monitoringPvr.isLoading) const CommonLoading()
          ])));
    });
  }
}
