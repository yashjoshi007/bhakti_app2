import 'dart:developer';
import 'package:bhakti_app/config.dart';

class BookReadingDialog extends StatelessWidget {
  final int originalReadingHour, originalReadingMinute, index;
  final dynamic data;

  const BookReadingDialog(this.originalReadingHour, this.originalReadingMinute,
      this.index, this.data,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context3, setState) {
      return Consumer<HomeScreenProvider>(
          builder: (context2, homeScreenPvr, child) {
        int newIndex = homeScreenPvr.bookRmtCnfgList.indexWhere((element) {
          return element['book_id'].toString() == data["book_id"].toString();
        });
        debugPrint("fjdhgbf :${homeScreenPvr.bookRmtCnfgList[newIndex]}");

        List<dynamic> chaptersList =
            homeScreenPvr.bookRmtCnfgList[newIndex]['chapters'];

        debugPrint("chaptersList :::: $chaptersList");
        log("chosen value ${homeScreenPvr.bookReadingCurrentHour}");
        return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: Sizes.s10),
            backgroundColor: appColor(context).appTheme.trans,
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.r8),
                    color: appColor(context).appTheme.whiteColor),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                              child: Text(
                                  homeScreenPvr.bookRmtCnfgList[newIndex]
                                      ['book_name'],
                                  style: appCss.philosopherBold18.textColor(
                                      appColor(context).appTheme.primary)))
                          .paddingOnly(top: 10, bottom: 10),
                      Text(language(context, appFonts.hour),
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 1,
                          totalCount: homeScreenPvr.bookReadingTotalHour,
                          initValue: homeScreenPvr.bookReadingCurrentHour,
                          currentIndex: homeScreenPvr.bookReadingCurrentHour,
                          onValueChanged: (val) {
                            homeScreenPvr.notifyListeners();
                            homeScreenPvr.staticReadingBook24 =
                                "${val.toString().padLeft(2, '0')}:${homeScreenPvr.bookReadingCurrentMinute.toString().padLeft(2, '0')}";
                            homeScreenPvr.bookReadingCurrentHour =
                                int.parse(val);
                          }),
                      const VSpace(Insets.i15),
                      Text(language(context, appFonts.minute),
                          style: appCss.dmDenseMedium17
                              .textColor(appColor(context).appTheme.primary)),
                      const VSpace(Insets.i15),
                      CommonWheelSlider(
                          minCount: 0,
                          interval: 5,
                          totalCount: homeScreenPvr.bookReadingTotalMinute,
                          initValue: homeScreenPvr.bookReadingCurrentMinute,
                          currentIndex: homeScreenPvr.bookReadingCurrentMinute,
                          onValueChanged: (val) {
                            homeScreenPvr.notifyListeners();
                            homeScreenPvr.staticReadingBook24 =
                                "${homeScreenPvr.bookReadingCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";
                            homeScreenPvr.bookReadingCurrentMinute =
                                int.parse(val);
                            homeScreenPvr.updateData(context);
                            homeScreenPvr.notifyListeners();
                          }),
                      const VSpace(Insets.i20),
                      if (chaptersList.isNotEmpty)
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: homeScreenPvr.containerBorderColor)),
                            height: homeScreenPvr.chosenValue != null
                                ? null
                                : Sizes.s46,
                            alignment: Alignment.center,
                            child: CommonContainerTile(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: homeScreenPvr.chosenValue,
                                    items: chaptersList
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: chaptersList.indexOf(
                                                                      value) ==
                                                                  0
                                                              ? Colors
                                                                  .transparent
                                                              : appColor(context)
                                                                  .appTheme
                                                                  .lightText
                                                                  .withOpacity(
                                                                      0.2),
                                                          width: 1))),
                                              child: Text(value,
                                                  style: appCss.dmDenseRegular14
                                                      .textColor(appColor(context)
                                                          .appTheme
                                                          .rulesClr),
                                                  overflow: TextOverflow.visible)));
                                    }).toList(),
                                    icon:
                                        SvgPicture.asset(eSvgAssets.arrowDown1),
                                    underline: Container(),
                                    hint: Text(
                                        language(
                                            context, appFonts.selectChapter),
                                        style: appCss.dmDenseRegular14
                                            .textColor(appColor(context)
                                                .appTheme
                                                .rulesClr),
                                        overflow: TextOverflow.visible),
                                    onChanged: (value) {
                                      homeScreenPvr.chosenValue = value;
                                      homeScreenPvr.notifyListeners();
                                      homeScreenPvr.containerBorderColor =
                                          Colors.white;
                                    }))),
                      const VSpace(Insets.i20),
                      CommonSelectionButton(onTapOne: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.containerBorderColor = Colors.white;
                        homeScreenPvr.notifyListeners();
                        homeScreenPvr.bookReadingCurrentHour =
                            originalReadingHour;
                        homeScreenPvr.bookReadingCurrentMinute =
                            originalReadingMinute;
                        homeScreenPvr.chosenValue =
                            homeScreenPvr.originalChosenValue;
                        Navigator.pop(context);
                      }, onTapTwo: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        homeScreenPvr.notifyListeners();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        homeScreenPvr.notifyListeners();
                        if (homeScreenPvr.chosenValue != null) {
                          homeScreenPvr.getDataList[index]['reading_time'] =
                              homeScreenPvr.staticReadingBook24;
                          data['reading_time'] =
                              homeScreenPvr.staticReadingBook24;
                          homeScreenPvr.notifyListeners();
                          int appArrayIndex = appArray.bookList.indexWhere(
                            (element) => element["book_id"] == data['book_id'],
                          );
                          if (appArrayIndex >= 0) {
                            appArray.bookList[appArrayIndex]['reading_time'] =
                                homeScreenPvr.staticReadingBook24;
                            appArray.bookList[appArrayIndex]
                                    ['selected_chapters'] =
                                homeScreenPvr.chosenValue;

                            log("DD :${appArray.bookList[appArrayIndex]['selected_chapters']}");
                          }

                          int localIndex =
                              appArray.localBookList.indexWhere((apiItem) {
                            return apiItem['book_id'] == data['book_id'];
                          });

                          if (localIndex >= 0) {
                            appArray.localBookList[localIndex]['reading_time'] =
                                homeScreenPvr.staticReadingBook24;
                            appArray.localBookList[localIndex]
                                    ['selected_chapters'] =
                                homeScreenPvr.chosenValue;

                            log("DD :${appArray.localBookList[localIndex]['selected_chapters']}");
                          }
                          String jsonString =
                              jsonEncode(appArray.localBookList);
                          await prefs.setString('bookList', jsonString);
                          homeScreenPvr.getDataList[index]
                              ['selected_chapters'] = homeScreenPvr.chosenValue;
                          data['selected_chapters'] = homeScreenPvr.chosenValue;
                          homeScreenPvr.containerBorderColor = Colors.white;
                          appArray.selectedIndex = index;
                          homeScreenPvr.updateData(context,
                              getDataIndex: index);
                          homeScreenPvr.notifyListeners();
                          Navigator.pop(context);
                        } else {
                          homeScreenPvr.containerBorderColor = Colors.red;
                          homeScreenPvr
                              .notifyListeners(); // Call setState function
                        }
                      })
                    ]).paddingAll(Sizes.s15)));
      });
    });
  }
}
