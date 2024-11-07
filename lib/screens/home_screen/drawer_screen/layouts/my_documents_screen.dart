import 'package:bhakti_app/config.dart';

class MyDocumentScreen extends StatefulWidget {
  const MyDocumentScreen({super.key});

  @override
  State<MyDocumentScreen> createState() => _MyDocumentScreenState();
}

class _MyDocumentScreenState extends State<MyDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Stack(children: [
        Scaffold(
            body: RefreshIndicator(
                onRefresh: () => homeScreenPvr.refreshData(context),
                child: CommonBgWidget().commonBgImage(SingleChildScrollView(
                    child: Column(children: [
                  CommonAppBar(
                      hSpace: Insets.i80,
                      text: language(context, appFonts.myDocument),
                      onTap: () => Navigator.pop(context)),
                  const SizedBox(height: Insets.i25),
                  const DottedLayout(),
                  const SizedBox(height: Insets.i15),
                  const ProgressLayout(),
                  homeScreenPvr.myDownloadUrl.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeScreenPvr.myDownloadUrl.length,
                          itemBuilder: (context, index) {
                            return MyDocUrlLayout(index);
                          })
                      : Text(appFonts.noDocumentsAvailable,
                              style: appCss.dmDenseRegular14.textColor(
                                  appColor(context).appTheme.myDocumentColor))
                          .marginOnly(top: Insets.i150)
                ]).paddingSymmetric(horizontal: Insets.i20))))),
        if (homeScreenPvr.isLoading) const CommonLoading()
      ]);
    });
  }
}
