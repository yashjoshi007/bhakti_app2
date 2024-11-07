import 'package:bhakti_app/config.dart';

class HearOthersDialog extends StatelessWidget {
  final int originalOthersHour;
  final int originalOthersMinute;

  const HearOthersDialog(this.originalOthersHour, this.originalOthersMinute,
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
                              child: Text(language(context,appFonts.others),
                                  style: appCss.philosopherBold18.textColor(
                                      appColor(context).appTheme.primary)))
                          .paddingSymmetric(vertical: Sizes.s10),
                      Text(language(context,appFonts.hour),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(minCount: 0,
                          interval: 1,
                          currentIndex: homeScreenPvr.hearingOthersCurrentHour,
                          initValue: homeScreenPvr.hearingOthersCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onHearingOthersHour(val),
                          totalCount: homeScreenPvr.hearingOthersTotalHour),
                      const VSpace(Insets.i10),
                      Text(language(context,appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(minCount: 0,
                          interval: 5,
                          currentIndex:
                              homeScreenPvr.hearingOthersCurrentMinute,
                          initValue: homeScreenPvr.hearingOthersCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onHearingOthersMinute(val),
                          totalCount: homeScreenPvr.hearingOthersTotalMinute),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.hearingOthersCurrentHour =
                            originalOthersHour;
                        homeScreenPvr.hearingOthersCurrentMinute =
                            originalOthersMinute;
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.hearingOthersTime24 =
                            homeScreenPvr.staticHearingOthersTime24;
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
