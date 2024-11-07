import 'package:bhakti_app/config.dart';

class ChantingDialog extends StatelessWidget {
  final int originalRounds, originalQuality, index;

  const ChantingDialog(this.originalRounds, this.originalQuality, this.index,
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
                              child: Text(language(context,appFonts.chanting),
                                  style: appCss.philosopherBold18.textColor(
                                      appColor(context).appTheme.primary)))
                          .paddingSymmetric(vertical: Sizes.s10),
                      Text(language(context,appFonts.countOfRounds),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(minCount : 0,
                          interval: 1,
                          totalCount: homeScreenPvr.chantingCountTotalRounds,
                          initValue: homeScreenPvr.chantingCountCurrentRounds,
                          currentIndex:
                              homeScreenPvr.chantingCountCurrentRounds,
                          onValueChanged: (val) =>
                              homeScreenPvr.onChantingCountRounds(val, index)),
                      const VSpace(Insets.i10),
                      Text(language(context,appFonts.chantingQualityRating),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language(context,appFonts.poor),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: appColor(context)
                                        .appTheme
                                        .chantingClr)),
                            Text(language(context,appFonts.bliss),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color:
                                        appColor(context).appTheme.chantingClr))
                          ]),
                      CommonWheelSlider(minCount: 1,
                          interval: 1,
                          totalCount: homeScreenPvr.chantingCountTotalQuality,
                          initValue: homeScreenPvr.chantingCountCurrentQuality,
                          currentIndex:
                              homeScreenPvr.chantingCountCurrentQuality,
                          onValueChanged: (val) =>
                              homeScreenPvr.onChantingCountQuality(val, index)),
                      const VSpace(Insets.i40),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.chantingList[index]['rounds'] =
                            originalRounds;
                        homeScreenPvr.chantingList[index]['quality'] =
                            originalQuality;
                        homeScreenPvr.notifyListeners();
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        homeScreenPvr.chantingList[index] =
                            homeScreenPvr.chantingListStatic[index];
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.updateData(context);
                        Navigator.pop(context);
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
