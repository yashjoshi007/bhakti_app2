import 'package:bhakti_app/config.dart';
import 'dart:developer' as developer;

class BookLayout extends StatefulWidget {
  const BookLayout({super.key});

  @override
  State<BookLayout> createState() => _BookLayoutState();
}

class _BookLayoutState extends State<BookLayout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      homeScreenPvr.getDataList = homeScreenPvr.getCombinedData() ?? [];
      // print(
      //     "Books in combined : END0------------- ${homeScreenPvr.getDataList[0]}");
      int newIndex = -1;

      // //developer.log(""message 2 : ${appArray.combineList}");
      return SizedBox(
          height: Sizes.s180,
          child: ScrollablePositionedList.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeScreenPvr.getDataList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      homeScreenPvr.notifyListeners();
                      homeScreenPvr.showBookReadingDialog(
                          context, index, homeScreenPvr.getDataList[index]);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: appColor(context).appTheme.shadowClr,
                                  blurRadius: AppRadius.r12,
                                  offset: const Offset(0, 2),
                                  spreadRadius: 0)
                            ],
                            color: appColor(context).appTheme.whiteColor),
                        height: Sizes.s179,
                        width: Sizes.s115,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r2),
                                  child: Image.network(
                                      homeScreenPvr.getDataList[index]
                                              ['image_src']
                                          .toString(),
                                      height: Sizes.s132)),
                              const VSpace(Insets.i6),
                              Text(
                                  homeScreenPvr.getDataList[index]
                                          ['reading_time'] ??
                                      language(context, appFonts.timeZero),
                                  style: homeScreenPvr.getDataList[index]
                                              ['reading_time'] ==
                                          null
                                      ? appCss.dmDenseMedium16.textColor(
                                          appColor(context)
                                              .appTheme
                                              .emptyTxtClr)
                                      : appCss.dmDenseMedium16.textColor(
                                          appColor(context).appTheme.primary))
                            ])));
              }));
    });
  }
}
