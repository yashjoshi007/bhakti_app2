import 'package:bhakti_app/config.dart';

class HearGuruMaharajaDialog extends StatelessWidget {
  final int originalGuruHour;
  final int originalGuruMin;

  const HearGuruMaharajaDialog(this.originalGuruHour, this.originalGuruMin,
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
                                  language(context, appFonts.guruMaharaja),
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
                          currentIndex: homeScreenPvr.hearingGuruCurrentHour,
                          initValue: homeScreenPvr.hearingGuruCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onHearGuruMaharajaHour(val),
                          totalCount: homeScreenPvr.hearingGuruTotalHour),
                      const VSpace(Insets.i10),
                      Text(language(context, appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          currentIndex: homeScreenPvr.hearingGuruCurrentMinute,
                          initValue: homeScreenPvr.hearingGuruCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onHearGuruMaharajaMinute(val),
                          totalCount: homeScreenPvr.hearingGuruTotalMinute),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.hearingGuruCurrentHour = originalGuruHour;
                        homeScreenPvr.hearingGuruCurrentMinute =
                            originalGuruMin;
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.hearingGuruTime24 =
                            homeScreenPvr.staticHearingGuruTime24;
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
