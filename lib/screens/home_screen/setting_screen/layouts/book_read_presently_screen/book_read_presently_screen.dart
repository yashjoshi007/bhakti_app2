import 'package:bhakti_app/config.dart';

class BookReadPresentlyScreen extends StatelessWidget {
  final List? bookReadingList;

  const BookReadPresentlyScreen({super.key, this.bookReadingList});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: CommonBgWidget().commonBgImage(SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CommonAppBar(
                isWidth: true,
                text: language(context, appFonts.booksReadingPresently),
                onTap: () => Navigator.pop(context),
                hSpace: MediaQuery.of(context).size.width * 0.04),
            const VSpace(Insets.i10),
            CommonTextField(
                prefixIcon: Row(children: [
                  SvgPicture.asset(eSvgAssets.searchNormal)
                      .paddingOnly(right: Insets.i10, left: Insets.i10),
                  SvgPicture.asset(eSvgAssets.line)
                      .paddingOnly(right: Insets.i10)
                ]),
                height: Insets.i50,
                onChanged: (query) => homeScreenPvr.filterBooks(query),
                controller: homeScreenPvr.searchHere,
                hintText: language(context, appFonts.searchForaBook)),
            const VSpace(Insets.i10),
            CommonLeftSideText(text: language(context, appFonts.listOfBooks)),
            const VSpace(Insets.i10),
            Container(
                margin: const EdgeInsets.only(bottom: Insets.i20),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    color: appColor(context).appTheme.whiteColor,
                    borderRadius: BorderRadius.circular(Insets.i6),
                    boxShadow: [
                      BoxShadow(
                          color: appColor(context).appTheme.shadowClr,
                          blurRadius: Insets.i16,
                          offset: const Offset(0, 4),
                          spreadRadius: 0)
                    ]),
                child: homeScreenPvr.isSearch == true
                    ? ListView.builder(
                        itemCount: homeScreenPvr.searchData.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Insets.i15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BookReadingPresentlyLayout(
                              data: homeScreenPvr.searchData[index],
                              index: index);
                        })
                    : ListView.builder(
                        itemCount: homeScreenPvr.bookRmtCnfgList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(Insets.i15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BookReadingPresentlyLayout(
                              data: homeScreenPvr.bookRmtCnfgList[index],
                              index: index);
                        }))
          ]).paddingSymmetric(horizontal: Insets.i20))));
    });
  }
}
