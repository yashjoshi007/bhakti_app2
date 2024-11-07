import 'package:bhakti_app/config.dart';

class PreachingDialog extends StatelessWidget {
  final int originalPreachingHour;
  final int originalPreachingMin;

  const PreachingDialog(this.originalPreachingHour, this.originalPreachingMin,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Consumer<HomeScreenProvider>(
          builder: (context, homeScreenPvr, child) {
        return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
            backgroundColor: Colors.transparent,
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
                              child: Text(language(context,appFonts.preaching),
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
                          currentIndex: homeScreenPvr.preachingCurrentHour,
                          initValue: homeScreenPvr.preachingCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onPreachingHour(val),
                          totalCount: homeScreenPvr.preachingTotalHour),
                      const VSpace(Insets.i10),
                      Text(language(context,appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(minCount: 0,
                          interval: 5,
                          currentIndex: homeScreenPvr.preachingCurrentMinute,
                          initValue: homeScreenPvr.preachingCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onPreachingMinute(val),
                          totalCount: homeScreenPvr.preachingTotalMinute),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.preachingCurrentHour =
                            originalPreachingHour;
                        homeScreenPvr.preachingCurrentMinute =
                            originalPreachingMin;
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.preachingTime24 =
                            homeScreenPvr.staticPreachingTime24;
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
