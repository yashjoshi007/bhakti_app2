import 'package:intl/intl.dart';
import 'dart:developer';
import 'package:bhakti_app/config.dart';

class MonitoringSingleUserLayout extends StatefulWidget {
  const MonitoringSingleUserLayout({super.key});

  @override
  State<MonitoringSingleUserLayout> createState() =>
      _MonitoringSingleUserLayoutState();
}

class _MonitoringSingleUserLayoutState
    extends State<MonitoringSingleUserLayout> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      List<String> allDataUIDs = monitoringPvr.allDataList
          .map<String>((item) => item['uid'] as String)
          .toList();

      dynamic userSleepData = monitoringPvr.sleepData(context, settingPvr);
      dynamic userWorshipData = monitoringPvr.worshipData(context, settingPvr);
      dynamic userChantingData =
          monitoringPvr.chantingData(context, settingPvr);
      dynamic userRegulationData =
          monitoringPvr.regulationData(context, settingPvr);
      dynamic userBookReadData =
          monitoringPvr.bookReadData(context, settingPvr);
      dynamic userAssociationData =
          monitoringPvr.associationData(context, settingPvr);
      dynamic userBookDistributionData =
          monitoringPvr.bookDistributionData(context, settingPvr);
      if (userSleepData.isNotEmpty &&
          userWorshipData.isNotEmpty &&
          userChantingData.isNotEmpty &&
          userRegulationData.isNotEmpty &&
          userBookReadData.isNotEmpty &&
          userAssociationData.isNotEmpty &&
          userBookDistributionData.isNotEmpty) {
        log("is true ");
        return SingleChildScrollView(
            child: const Column(children: [
          MonitoringSleepLayout(),
          MonitoringWorshipLayout(),
          MonitoringChantingLayout(),
          MonitoringRegulationLayout(),
          MonitoringReadingLayout(),
          MonitoringAssociationLayout(),
          MonitoringBookDistributionLayout()
        ]).paddingSymmetric(horizontal: Insets.i20));
      }
      var selectedDateData =
          DateFormat("yyyy-MM-dd").format(monitoringPvr.selectedDate);
      String displayName = settingPvr.shareWithMeList.firstWhere(
          (item) => allDataUIDs.contains(item['uid']))['display_name'];

      return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(eSvgAssets.infoIcon, height: 50),
            const SizedBox(height: 15),
            Text(
                textAlign: TextAlign.center,
                "${language(context, appFonts.sadhanaRecordNotFoundFor)} $displayName ${language(context, appFonts.on)} $selectedDateData",
                overflow: TextOverflow.fade,
                style: appCss.dmDenseLight16
                    .textColor(appColor(context).appTheme.lightText))
          ]));
    });
  }
}
