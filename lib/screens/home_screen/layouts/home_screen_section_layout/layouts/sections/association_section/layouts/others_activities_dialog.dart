import 'package:bhakti_app/config.dart';

class OtherActivitiesDialog extends StatelessWidget {
  final int originalOthersActivitiesHour;
  final int originalOthersActivitiesMinute;

  const OtherActivitiesDialog(
      this.originalOthersActivitiesHour, this.originalOthersActivitiesMinute,
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
                              child: Text(language(context,appFonts.otherActivities),
                                  style: appCss.philosopherBold18.textColor(
                                      appColor(context).appTheme.primary)))
                          .paddingSymmetric(vertical: Sizes.s10),
                      Text(language(context,appFonts.hour),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(minCount: 0,
                          interval: 1,
                          currentIndex:
                              homeScreenPvr.othersActivitiesCurrentHour,
                          initValue: homeScreenPvr.othersActivitiesCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onOthersActivitiesHour(val),
                          totalCount: homeScreenPvr.othersActivitiesTotalHour),
                      const VSpace(Insets.i10),
                      Text(language(context,appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(minCount: 0,
                          interval: 5,
                          currentIndex:
                              homeScreenPvr.othersActivitiesCurrentMinute,
                          initValue:
                              homeScreenPvr.othersActivitiesCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onOthersActivitiesMinute(val),
                          totalCount:
                              homeScreenPvr.othersActivitiesTotalMinute),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.othersActivitiesCurrentHour =
                            originalOthersActivitiesHour;
                        homeScreenPvr.othersActivitiesCurrentMinute =
                            originalOthersActivitiesMinute;
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.othersActivitiesTime24 =
                            homeScreenPvr.staticOthersActivitiesTime24;
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
