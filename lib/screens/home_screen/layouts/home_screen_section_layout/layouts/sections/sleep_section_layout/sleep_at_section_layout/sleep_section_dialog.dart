import 'package:bhakti_app/config.dart';

class SleepAtSectionDialog extends StatelessWidget {
  final int originalHour;
  final int originalMinute;

  const SleepAtSectionDialog(this.originalHour, this.originalMinute,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Consumer<HomeScreenProvider>(
          builder: (context, homeScreenPvr, child) {
        return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
            backgroundColor: appColor(context).appTheme.trans,
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    color: appColor(context).appTheme.whiteColor),
                width: double.infinity,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                              child: Text(
                                  language(context, appFonts.sleepingTime),
                                  style: appCss.philosopherBold18.textColor(
                                      appColor(context).appTheme.primary)))
                          .paddingSymmetric(vertical: Sizes.s10),
                      Text(language(context, appFonts.hour),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 1,
                          totalCount: homeScreenPvr.sleepTotalHour,
                          initValue: homeScreenPvr.sleepCurrentHour,
                          currentIndex: homeScreenPvr.sleepCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onSleepAtHour(val)),
                      const VSpace(Insets.i15),
                      Text(language(context, appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          totalCount: homeScreenPvr.sleepTotalMinute,
                          initValue: homeScreenPvr.sleepCurrentMinute,
                          currentIndex: homeScreenPvr.sleepCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onSleepAtMinute(val)),
                      const VSpace(Insets.i40),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.sleepCurrentHour = originalHour;
                        homeScreenPvr.sleepCurrentMinute = originalMinute;
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        int hour = homeScreenPvr.sleepCurrentHour;
                        int minute = homeScreenPvr.sleepCurrentMinute;

                        // Adjust hour for 12-hour format
                        int hour12 = hour % 12;
                        if (hour12 == 0) {
                          hour12 = 12;
                        }
                        String period = (hour < 12) ? 'AM' : 'PM';

                        homeScreenPvr.sleepAt =
                            "${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
