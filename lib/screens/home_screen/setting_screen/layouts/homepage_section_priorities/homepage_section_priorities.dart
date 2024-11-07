import 'package:bhakti_app/config.dart';

import 'home_page_reorder_layout.dart';

class HomePageSection extends StatelessWidget {
  const HomePageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
              leading: Container(),
              backgroundColor: appColor(context).appTheme.trans,
              titleSpacing: 0,
              leadingWidth: 0,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const HSpace(Insets.i20),
                SvgPicture.asset(eSvgAssets.arrowLeft)
                    .inkWell(onTap: () => Navigator.pop(context)),
                const HSpace(Insets.i30),
                Expanded(
                    child: Text(language(context, appFonts.homePageSection),
                        overflow: TextOverflow.ellipsis,
                        style: appCss.philosopherBold28
                            .textColor(appColor(context).appTheme.oneText)))
              ])),
          body: CommonBgWidget().commonBgImage(SingleChildScrollView(
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                VSpace(Insets.i120),
                Column(children: [
                  SizedBox(height: Sizes.s580, child: HomePageReorderLayout())
                ])
              ]).paddingSymmetric(horizontal: Sizes.s20))));
    });
  }
}
