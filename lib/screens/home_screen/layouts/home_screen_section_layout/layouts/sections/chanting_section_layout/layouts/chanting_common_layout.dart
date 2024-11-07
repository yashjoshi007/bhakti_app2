import 'package:bhakti_app/config.dart';

class ChantingCommon extends StatelessWidget {
  const ChantingCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (BuildContext context, homeScreenPvr, child) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: homeScreenPvr.chantingList
                  .asMap()
                  .entries
                  .map((e) => CommonChantingContainer(
                      style: e.value['rounds'] == 0
                          ? appCss.dmDenseBold24
                              .textColor(appColor(context).appTheme.emptyTxtClr)
                          : appCss.dmDenseBold24
                              .textColor(appColor(context).appTheme.primary),
                      text:
                          language(context, homeScreenPvr.chantingTitle[e.key]),
                      chantingText:
                          language(context, e.value['rounds'].toString()),
                      onTap: () {
                        homeScreenPvr.onChantingCountSelect(context, e.key);
                      }))
                  .toList()));
    });
  }
}
