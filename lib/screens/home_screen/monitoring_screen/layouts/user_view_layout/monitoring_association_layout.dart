import 'package:bhakti_app/config.dart';

class MonitoringAssociationLayout extends StatelessWidget {
  const MonitoringAssociationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userAssociationData = monitoringPvr.associationData(context, settingPvr);
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userAssociationData.length,
          itemBuilder: (context, index) {
            dynamic associationData = userAssociationData[index];
            return Column(children: [
              CommonLeftSideText(text: language(context,appFonts.association)),
              const VSpace(Insets.i10),
              CommonContainerTile(
                  paddingArea: const EdgeInsets.symmetric(
                      vertical: Sizes.s20, horizontal: Sizes.s15),
                  child: Column(children: [
                    SingleUserLayout(
                        text: language(context,appFonts.hearingSrilaPrabupada),
                        text1: language(context,associationData['Prabhupada'])),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.hearingGuruMaharaja),
                        text1: language(context,associationData['Guru Maharaja'])),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.hearingOthers),
                        text1: language(context,associationData['Others'])),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.preaching), text1: language(context,associationData['Preaching'])),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.otherActivities),
                        text1: language(context,associationData['Other Activities'])),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.total),
                        text1: language(context,associationData['Total Association Time']))
                  ])),
              const VSpace(Insets.i10)
            ]);
          });
    });
  }
}
