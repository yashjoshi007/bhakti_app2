import 'package:bhakti_app/config.dart';

class MonitoringBookDistributionLayout extends StatelessWidget {
  const MonitoringBookDistributionLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userBookDistributionData =
          monitoringPvr.bookDistributionData(context, settingPvr);
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userBookDistributionData.length,
          itemBuilder: (context, index) {
            dynamic bookDistributionData = userBookDistributionData[index];
            return Column(children: [
              CommonLeftSideText(
                  text: language(context, appFonts.bookDistribution)),
              const VSpace(Insets.i10),
              CommonContainerTile(
                  paddingArea: const EdgeInsets.symmetric(
                      vertical: Sizes.s20, horizontal: Sizes.s15),
                  child: Column(children: [
                    SingleUserLayout(
                        text: language(context, appFonts.smallBooks),
                        text1: language(context,
                            bookDistributionData['Small Books'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.mediumBooks),
                        text1: language(context,
                            bookDistributionData['Medium Books'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.bigBooks),
                        text1: language(context,
                            bookDistributionData['Big Books'].toString()))
                  ])),
              const VSpace(Insets.i10)
            ]);
          });
    });
  }
}
