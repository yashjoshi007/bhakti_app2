import 'package:bhakti_app/config.dart';

class MonitoringSleepLayout extends StatelessWidget {
  const MonitoringSleepLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userSleepData = monitoringPvr.sleepData(context, settingPvr);
      if (userSleepData.isNotEmpty) {
        return Column(children: [
          CommonLeftSideText(text: language(context, appFonts.sleep)),
          const VSpace(Insets.i10),
          CommonContainerTile(
              paddingArea: const EdgeInsets.symmetric(
                  vertical: Sizes.s20, horizontal: Sizes.s15),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userSleepData.length,
                  itemBuilder: (context, index) {
                    dynamic sleepData = userSleepData[index];
                    return Column(children: [
                      SingleUserLayout(
                          text: language(context, appFonts.sleptTime),
                          text1: language(context, sleepData['Sleep at'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.wokeUpAt),
                          text1: language(context, sleepData['Woke up at'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.sleepDuration),
                          text1: language(context, sleepData['Duration']))
                    ]);
                  })),
          const VSpace(Insets.i10)
        ]);
      } else {
        return Container();
      }
    });
  }
}
