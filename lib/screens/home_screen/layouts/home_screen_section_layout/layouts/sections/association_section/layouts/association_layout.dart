import 'package:bhakti_app/config.dart';

class AssociationLayout extends StatelessWidget {
  const AssociationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Stack(children: [
              CommonAssociationSection(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(eSvgAssets.hearing),
                          const HSpace(Insets.i8),
                          Text(language(context, homeScreenPvr.hearingSpTime24),
                              style: homeScreenPvr.hearingSpTime24 ==
                                  language(context,appFonts.timeZero)
                                  ? appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.emptyTxtClr)
                                  : appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.primary))
                        ]).paddingOnly(left: Sizes.s10, top: Sizes.s4),
                    Text(language(context, language(context,appFonts.prabhupada)),
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.lightText))
                        .paddingOnly(left: Sizes.s10)
                  ])),
              const Positioned(
                  right: Sizes.s14,
                  top: Sizes.s7,
                  child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
              const Positioned(
                  left: Sizes.s60,
                  top: 16.75,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
              const Positioned(
                  left: Sizes.s100,
                  top: Sizes.s52,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
            ]).inkWell(onTap: () => homeScreenPvr.onHearPrabhupada(context)),
            const HSpace(Insets.i15),
            Stack(children: [
              CommonAssociationSection(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(eSvgAssets.hearing),
                          const HSpace(Insets.i8),
                          Text(
                              language(
                                  context, homeScreenPvr.hearingGuruTime24),
                              style: homeScreenPvr.hearingGuruTime24 ==
                                  language(context,appFonts.timeZero)
                                  ? appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.emptyTxtClr)
                                  : appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.primary))
                        ]).paddingOnly(left: Sizes.s10, top: Sizes.s4),
                    Text(language(context, appFonts.guruMaharaja),
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.lightText))
                        .paddingOnly(left: Sizes.s10)
                  ])),
              const Positioned(
                  left: Sizes.s64,
                  top: Sizes.s7,
                  child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
              const Positioned(
                  left: Sizes.s60,
                  top: 16.75,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
              const Positioned(
                  left: Sizes.s100,
                  top: Sizes.s52,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
            ]).inkWell(onTap: () => homeScreenPvr.onHearGuruMaharaja(context)),
            const HSpace(Insets.i15),
            Stack(children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                      boxShadow: [
                        BoxShadow(
                            color: appColor(context).appTheme.shadowClr,
                            blurRadius: AppRadius.r8,
                            offset: const Offset(0, 4))
                      ],
                      color: appColor(context).appTheme.whiteColor),
                  height: Sizes.s86,
                  width: Sizes.s126,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(eSvgAssets.hearing),
                              const HSpace(Insets.i8),
                              Text(
                                  language(context,
                                      homeScreenPvr.hearingOthersTime24),
                                  style: homeScreenPvr.hearingOthersTime24 ==
                                      language(context,appFonts.timeZero)
                                      ? appCss.dmDenseMedium16.textColor(
                                          appColor(context)
                                              .appTheme
                                              .emptyTxtClr)
                                      : appCss.dmDenseMedium16.textColor(
                                          appColor(context).appTheme.primary))
                            ]).paddingOnly(left: Sizes.s10, top: Sizes.s4),
                        Text(language(context, appFonts.others),
                                style: appCss.dmDenseMedium12.textColor(
                                    appColor(context).appTheme.lightText))
                            .paddingOnly(left: Sizes.s10)
                      ])),
              const Positioned(
                  left: Sizes.s64,
                  top: Sizes.s7,
                  child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
              const Positioned(
                  left: Sizes.s60,
                  top: 16.75,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
              const Positioned(
                  left: Sizes.s100,
                  top: Sizes.s52,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
            ]).inkWell(onTap: () => homeScreenPvr.onHearOthers(context)),
            const HSpace(Insets.i15),
            Stack(children: [
              CommonAssociationSection(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(eSvgAssets.preaching),
                          const HSpace(Insets.i8),
                          Text(language(context, homeScreenPvr.preachingTime24),
                              style: homeScreenPvr.preachingTime24 == language(context,appFonts.timeZero)
                                  ? appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.emptyTxtClr)
                                  : appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.primary))
                        ]).paddingOnly(left: Sizes.s10, top: Sizes.s4),
                    Text(language(context, appFonts.preaching),
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.lightText))
                        .paddingOnly(left: Sizes.s10)
                  ])),
              const Positioned(
                  right: Sizes.s16,
                  top: Sizes.s7,
                  child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
              const Positioned(
                  left: Sizes.s66,
                  bottom: Sizes.s2,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
              const Positioned(
                  left: Sizes.s136,
                  top: Sizes.s61,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
            ]).inkWell(onTap: () => homeScreenPvr.onPreaching(context)),
            const HSpace(Insets.i15),
            Stack(children: [
              CommonAssociationSection(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(eSvgAssets.hearing),
                          const HSpace(Insets.i8),
                          Text(
                              language(context,
                                  homeScreenPvr.othersActivitiesTime24),
                              style: homeScreenPvr.othersActivitiesTime24 ==
                                  language(context,appFonts.timeZero)
                                  ? appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.emptyTxtClr)
                                  : appCss.dmDenseMedium16.textColor(
                                      appColor(context).appTheme.primary))
                        ]).paddingOnly(left: Sizes.s10, top: Sizes.s4),
                    Text(language(context, appFonts.othersActivities),
                            style: appCss.dmDenseMedium12.textColor(
                                appColor(context).appTheme.lightText))
                        .paddingOnly(left: Sizes.s10)
                  ])),
              const Positioned(
                  left: Sizes.s64,
                  top: Sizes.s7,
                  child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
              const Positioned(
                  left: Sizes.s60,
                  top: 16.75,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
              const Positioned(
                  left: Sizes.s100,
                  top: Sizes.s52,
                  child:
                      CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
            ]).inkWell(onTap: () => homeScreenPvr.onOtherActivities(context))
          ]));
    });
  }
}
