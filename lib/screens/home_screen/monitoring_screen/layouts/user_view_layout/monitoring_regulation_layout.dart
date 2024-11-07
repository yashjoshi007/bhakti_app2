import 'package:bhakti_app/config.dart';

class MonitoringRegulationLayout extends StatelessWidget {
  const MonitoringRegulationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userRegulationData =
          monitoringPvr.regulationData(context, settingPvr);
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userRegulationData.length,
          itemBuilder: (context, index) {
            dynamic regulationData = userRegulationData[index];
            return Column(children: [
              CommonLeftSideText(text: language(context,appFonts.regulations)),
              const VSpace(Insets.i10),
              CommonContainerTile(
                  paddingArea: const EdgeInsets.symmetric(
                      vertical: Sizes.s20, horizontal: Sizes.s15),
                  child: Column(children: [
                    SingleUserLayout(
                        isAllSvg: true,
                        text: language(context,appFonts.noMeat),
                        svgImage1: regulationData['No Meat Eating'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isAllSvg: true,
                        text: language(context,appFonts.noIntox),
                        svgImage1: regulationData['No Intoxication'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isAllSvg: true,
                        text: language(context,appFonts.noIllicit),
                        svgImage1: regulationData['No Illicit Sex'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isAllSvg: true,
                        text: language(context,appFonts.noGambling),
                        svgImage1: regulationData['No Gambling'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong),
                    SvgPicture.asset(eSvgAssets.lineRuler,
                            width: MediaQuery.of(context).size.width * 1)
                        .marginSymmetric(vertical: 10),
                    SingleUserLayout(
                        isAllSvg: true,
                        text: language(context,appFonts.onlyPrasadam),
                        svgImage1: regulationData['Only Prasadam'] == true
                            ? eSvgAssets.right
                            : eSvgAssets.wrong)
                  ])),
              const VSpace(Insets.i10)
            ]);
          });
    });
  }
}
