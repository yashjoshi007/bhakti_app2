import 'package:bhakti_app/config.dart';

class WokeUpSectionDialog extends StatelessWidget {
  final int originalHour;
  final int originalMinute;

  const WokeUpSectionDialog(this.originalHour, this.originalMinute,
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
                                  language(context, appFonts.wakeUpTime),
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
                          totalCount: homeScreenPvr.wokeUpTotalHour,
                          initValue: homeScreenPvr.wokeUpCurrentHour,
                          currentIndex: homeScreenPvr.wokeUpCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onWokeUpHour(val)),
                      const VSpace(Insets.i15),
                      Text(language(context, appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          totalCount: homeScreenPvr.wokeUpTotalMinute,
                          initValue: homeScreenPvr.wokeUpCurrentMinute,
                          currentIndex: homeScreenPvr.wokeUpCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onWokeUpMinute(val)),
                      const VSpace(Insets.i40),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.wokeUpCurrentHour = originalHour;
                        homeScreenPvr.wokeUpCurrentMinute = originalMinute;
                        homeScreenPvr.notifyListeners();
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        int hour = homeScreenPvr.wokeUpCurrentHour;
                        int minute = homeScreenPvr.wokeUpCurrentMinute;

                        // Adjust hour for 12-hour format
                        int hour12 = hour % 12;
                        if (hour12 == 0) {
                          hour12 = 12;
                        }
                        String period = (hour < 12) ? 'AM' : 'PM';

                        homeScreenPvr.wakeupTime =
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
