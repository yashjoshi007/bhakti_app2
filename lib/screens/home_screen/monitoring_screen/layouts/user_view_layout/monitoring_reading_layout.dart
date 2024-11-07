import 'package:bhakti_app/config.dart';

class MonitoringReadingLayout extends StatelessWidget {
  const MonitoringReadingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context1, monitoringPvr, settingPvr, child) {
      dynamic userBookReadData =
          monitoringPvr.bookReadData(context, settingPvr);
      if (userBookReadData.isNotEmpty) {
        return Column(children: [
          CommonLeftSideText(text: language(context, appFonts.bookReading)),
          const VSpace(Insets.i10),
          CommonContainerTile(
              paddingArea: const EdgeInsets.symmetric(
                  vertical: Sizes.s20, horizontal: Sizes.s15),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userBookReadData.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      SingleUserLayout(
                          text: language(context, appFonts.bhagavadGita),
                          text1: language(
                              context, userBookReadData[index]['Gita'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.bhagavatham),
                          text1: language(
                              context, userBookReadData[index]['Bhagavatham'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.cC),
                          text1:
                              language(context, userBookReadData[index]['CC'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.others),
                          text1: language(
                              context, userBookReadData[index]['Others'])),
                      SvgPicture.asset(eSvgAssets.lineRuler,
                              width: MediaQuery.of(context).size.width * 1)
                          .marginSymmetric(vertical: 10),
                      SingleUserLayout(
                          text: language(context, appFonts.total),
                          text1: language(
                              context, userBookReadData[index]['Total']))
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
