import 'dart:developer';

import 'package:bhakti_app/config.dart';

class HearPrabhupadaDialog extends StatelessWidget {
  final int originalSpHour, originalSpMin;

  const HearPrabhupadaDialog(this.originalSpHour, this.originalSpMin,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      log("ajksdgajkfajfad $originalSpHour $originalSpMin");
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
                                  language(context, appFonts.prabhupada),
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
                          currentIndex: homeScreenPvr.hearingSpCurrentHour,
                          initValue: homeScreenPvr.hearingSpCurrentHour,
                          onValueChanged: (val) {
                            homeScreenPvr.onHearPrabhupadaHour(val);
                          },
                          totalCount: homeScreenPvr.hearingSpTotalHour),
                      const VSpace(Insets.i10),
                      Text(language(context, appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          currentIndex: homeScreenPvr.hearingSpCurrentMinute,
                          initValue: homeScreenPvr.hearingSpCurrentMinute,
                          onValueChanged: (val) {
                            log("val val $val");
                            homeScreenPvr.notifyListeners();
                            homeScreenPvr.onHearPrabhupadaMinute(val);
                            homeScreenPvr.notifyListeners();
                          },
                          totalCount: homeScreenPvr.hearingSpTotalMinute),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.hearingSpCurrentHour = originalSpHour;
                        homeScreenPvr.hearingSpCurrentMinute = originalSpMin;
                        homeScreenPvr.notifyListeners();
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.hearingSpTime24 =
                            homeScreenPvr.staticHearingSpTime24;
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
