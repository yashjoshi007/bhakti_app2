import '../../../../../config.dart';

class DottedLayout extends StatelessWidget {
  const DottedLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return DottedBorder(
          dashPattern: const [5, 5, 5, 5, 5, 5],
          strokeWidth: 1,
          radius: const Radius.circular(AppRadius.r8),
          borderType: BorderType.RRect,
          color: appColor(context).appTheme.primary,
          child: Container(
              height: Sizes.s132,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  color: appColor(context).appTheme.whiteColor),
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(eSvgAssets.documentUpload),
                    const SizedBox(height: Insets.i10),
                    Text(language(context, appFonts.onlyPdf),
                        style: appCss.dmDenseRegular14.textColor(
                            appColor(context).appTheme.myDocumentColor)),
                    const SizedBox(height: Insets.i8),
                    Text(language(context, appFonts.clickHere),
                        style: appCss.dmDenseMedium12
                            .textDecoration(TextDecoration.underline,
                                color: appColor(context).appTheme.primary)
                            .textColor(appColor(context).appTheme.primary))
                  ]))).inkWell(onTap: () => homeScreenPvr.filePick(context));
    });
  }
}
