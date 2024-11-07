import 'package:bhakti_app/config.dart';

class MonitoringChantingLayout extends StatelessWidget {
  const MonitoringChantingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userChantingData =
          monitoringPvr.chantingData(context, settingPvr);

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userChantingData.length,
          itemBuilder: (context, index) {
            dynamic chantingData = userChantingData[index];
            return Column(children: [
              CommonLeftSideText(text: language(context, appFonts.chanting)),
              const VSpace(Insets.i10),
              CommonContainerTile(
                  paddingArea: const EdgeInsets.symmetric(
                      vertical: Sizes.s20, horizontal: Sizes.s15),
                  child: Column(children: [
                    SingleUserLayout(
                        text: language(context, appFonts.before630),
                        text1: language(context,
                            chantingData['Before 6:30 am'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.before830),
                        text1: language(context,
                            chantingData['Before 8:30 am'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.before10),
                        text1: language(
                            context, chantingData['Before 10 am'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.before930),
                        text1: language(context,
                            chantingData['Before 9:30 pm'].toString())),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context, appFonts.after930),
                        text1: language(
                            context, chantingData['After 9:30 pm'].toString())),
                    // SvgPicture.asset(eSvgAssets.lineRuler,
                    //         width: MediaQuery.of(context).size.width * 1)
                    //     .marginSymmetric(vertical: 10),
                    // SingleUserLayout(
                    //     text: language(context, appFonts.total),
                    //     text1:
                    //         language(context, chantingData['Total'].toString()))
                  ])),
              const VSpace(Insets.i10)
            ]);
          });
    });
  }
}
