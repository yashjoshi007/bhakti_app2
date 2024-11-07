import '../../../../../config.dart';

class ProgressLayout extends StatelessWidget {
  const ProgressLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Column(children: [
        if (homeScreenPvr.loading)
          CommonContainerTile(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(language(context, appFonts.uploadingFile),
                          style: appCss.dmDenseMedium16
                              .textColor(appColor(context).appTheme.primary)),
                      Text(
                          homeScreenPvr.fileSizeFormatted != null
                              ? homeScreenPvr.fileSizeFormatted!
                              : "",
                          style: appCss.dmDenseMedium14
                              .textColor(appColor(context).appTheme.lightText))
                    ]),
                CircularPercentIndicator(
                    radius: 27.0,
                    lineWidth: Sizes.s6,
                    animation: true,
                    percent: (homeScreenPvr.perc / 100),
                    center: Text('${homeScreenPvr.perc.toStringAsFixed(0)}%',
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText)),
                    backgroundColor: appColor(context).appTheme.processColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: appColor(context).appTheme.primary)
              ])),
        if (homeScreenPvr.isDownloading)
          CommonContainerTile(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(language(context, appFonts.downloadingFile),
                          style: appCss.dmDenseMedium16
                              .textColor(appColor(context).appTheme.primary)),
                    ]),
                CircularPercentIndicator(
                    radius: 27.0,
                    lineWidth: Sizes.s6,
                    animation: true,
                    percent: (homeScreenPvr.perc / 100),
                    center: Text('${homeScreenPvr.progress}%',
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText)),
                    backgroundColor: appColor(context).appTheme.processColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: appColor(context).appTheme.primary)
              ]))
      ]);
    });
  }
}
