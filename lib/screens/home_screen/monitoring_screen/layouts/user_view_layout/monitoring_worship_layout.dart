import 'package:bhakti_app/config.dart';

class MonitoringWorshipLayout extends StatelessWidget {
  const MonitoringWorshipLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
          dynamic userWorshipData = monitoringPvr.worshipData(context,settingPvr);
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userWorshipData.length,
          itemBuilder: (context, index) {
            dynamic worshipData = userWorshipData[index];
            return Column(children: [
              CommonLeftSideText(text: language(context,appFonts.worship)),
              const VSpace(Insets.i10),
              CommonContainerTile(
                  paddingArea: const EdgeInsets.symmetric(
                      vertical: Sizes.s20, horizontal: Sizes.s15),
                  child: Column(children: [
                    SingleUserLayout(
                        text: language(context,appFonts.mangalaArti),
                        text1: worshipData['Mangala Aarti']),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.guruAstaka),
                        svgImage: worshipData['Guru Astaka'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.narasimhaArti),
                        svgImage: worshipData['Narasimha Arti'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.tulasiArtiParikrama),
                        svgImage: worshipData['Tulasi Arti'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.guruArti),
                        svgImage: worshipData['Guru Arti'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.bhogaOffering),
                        svgImage: worshipData['Bhoga Offering'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        text: language(context,appFonts.sandhyaArti),
                        text1: worshipData['Sandhya Arti Time']),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.sandhyaArti),
                        svgImage: worshipData['Sandhya Arti'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.narasimhaArti),
                        svgImage: worshipData['Sandhya Narasimha Arti'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isTitle: true,
                        text: language(context,appFonts.bhogaOffering),
                        svgImage: worshipData['Sandhya Bhoga Offering'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong)
                  ])),
              const VSpace(Insets.i10)
            ]);
          });
    });
  }
}
