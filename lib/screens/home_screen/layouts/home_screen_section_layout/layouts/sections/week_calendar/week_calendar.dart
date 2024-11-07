import 'package:bhakti_app/config.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context1, homeScreenPvr, child) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        HorizontalWeekCalendar(
            datePickChange: homeScreenPvr.selectedDate,
            inactiveWeekColor: appColor(context).appTheme.rulesClr,
            activeBackgroundColor: appColor(context).appTheme.primary,
            activeTextColor: appColor(context).appTheme.whiteColor,
            isCallFun: homeScreenPvr.isCallFun,
            inactiveBackgroundColor: appColor(context).appTheme.whiteColor,
            inactiveDateColor: appColor(context).appTheme.lightText,
            disabledTextColor: appColor(context).appTheme.lightText,
            onWeekChange: (p0) {
              homeScreenPvr.dateList = p0;
              homeScreenPvr.getCalendarScoreData(context);
            },
            disabledBackgroundColor: appColor(context).appTheme.whiteColor,
            activeNavigatorColor: appColor(context).appTheme.primary,
            inactiveNavigatorColor: appColor(context).appTheme.lightText,
            onDateChange: (date, list) => {
                  homeScreenPvr.onCalendarDateChange(date, list: list),
                  homeScreenPvr.getData(context, isTap: true),
                  homeScreenPvr.getCalendarScoreData(context),
                })
      ]);
    });
  }
}
