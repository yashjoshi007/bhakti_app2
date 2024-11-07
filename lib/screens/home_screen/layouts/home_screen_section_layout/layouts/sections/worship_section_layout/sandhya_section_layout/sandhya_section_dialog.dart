import 'package:bhakti_app/config.dart';

class SandhyaSectionDialog extends StatelessWidget {
  final int originalSandhyaHour;
  final int originalSandhyaMinute;

  const SandhyaSectionDialog(
      this.originalSandhyaHour, this.originalSandhyaMinute,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context2, setState) {
      return Consumer<HomeScreenProvider>(
          builder: (context1, homeScreenPvr, child) {
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
                                  language(context, appFonts.sandhyaArti),
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
                          totalCount: homeScreenPvr.sandhyaArtiTotalHour,
                          initValue: homeScreenPvr.sandhyaArtiCurrentHour,
                          currentIndex: homeScreenPvr.sandhyaArtiCurrentHour,
                          onValueChanged: (val) =>
                              homeScreenPvr.onSandhyaArtiHour(val)),
                      const VSpace(Insets.i15),
                      Text(language(context, appFonts.minute),
                          textAlign: TextAlign.start,
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          currentIndex: homeScreenPvr.sandhyaArtiCurrentMinute,
                          initValue: homeScreenPvr.sandhyaArtiCurrentMinute,
                          onValueChanged: (val) =>
                              homeScreenPvr.onSandhyaArtiMinute(val),
                          totalCount: homeScreenPvr.sandhyaArtiTotalMinute),
                      const VSpace(Insets.i20),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: appColor(context).appTheme.whiteColor),
                          child: Column(
                              children: appArray.sandhyaTypeList
                                  .asMap()
                                  .entries
                                  .map((e) {
                            return Column(children: [
                              CommonAlertList(
                                  status: e.value['isOn'],
                                  text: language(context, e.value['artiType']),
                                  onToggle: (val) =>
                                      homeScreenPvr.onSandhyaToggle(val, e)),
                              const VSpace(Sizes.s10),
                              e.key == 2
                                  ? Container()
                                  : SvgPicture.asset(eSvgAssets.lineRuler),
                              e.key == 2 ? Container() : const VSpace(Sizes.s10)
                            ]);
                          }).toList())),
                      const VSpace(Insets.i20),
                      CommonSelectionButton(onTapOne: () {
                        homeScreenPvr.sandhyaArtiCurrentHour =
                            originalSandhyaHour;
                        homeScreenPvr.sandhyaArtiCurrentMinute =
                            originalSandhyaMinute;
                        homeScreenPvr.notifyListeners();
                        Navigator.pop(context);
                      }, onTapTwo: () {
                        int hour = homeScreenPvr.sandhyaArtiCurrentHour;
                        int minute = homeScreenPvr.sandhyaArtiCurrentMinute;

                        // Adjust hour for 12-hour format
                        int hour12 = hour % 12;
                        if (hour12 == 0) {
                          hour12 = 12;
                        }
                        String period = (hour < 12) ? 'AM' : 'PM';

                        homeScreenPvr.sandhyaArtiTime =
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
