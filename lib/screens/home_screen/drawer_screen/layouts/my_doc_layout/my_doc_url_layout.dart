import '../../../../../config.dart';

class MyDocUrlLayout extends StatelessWidget {
  final int index;

  const MyDocUrlLayout(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return CommonContainerTile(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          SvgPicture.asset(eSvgAssets.pdf),
          const HSpace(Insets.i12),
          SizedBox(
              width: 200,
              child: Text(homeScreenPvr.myDownloadUrl[index]['title'],
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.primary)))
        ]).inkWell(onTap: () {
          homeScreenPvr.downloadAndOpenPdf(
              homeScreenPvr.myDownloadUrl[index]['document_url'],
              homeScreenPvr.myDownloadUrl[index]['title'],
              context);
        }),
        Container(
                padding: const EdgeInsets.all(Sizes.s5),
                height: Sizes.s30,
                width: Sizes.s30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        appColor(context).appTheme.primary.withOpacity(0.06)),
                child: SvgPicture.asset(eSvgAssets.closeButton))
            .inkWell(
                onTap: () async =>
                    homeScreenPvr.deleteDocDialogOnTap(homeScreenPvr, context))
      ])).marginSymmetric(vertical: 5);
    });
  }
}
