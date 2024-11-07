import 'dart:developer';

import 'package:bhakti_app/config.dart';

class BookReadingPresentlyLayout extends StatelessWidget {
  final dynamic data;
  final int? index;

  const BookReadingPresentlyLayout({super.key, this.data, this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(data['image_src'],
                        fit: BoxFit.cover,
                        height: Insets.i70,
                        width: Insets.i50)),
                const SizedBox(width: Insets.i12),
                Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(data['book_name'],
                        overflow: TextOverflow.fade,
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.rulesClr)))
              ]),
          buildToggleButton(context, homeScreenPvr)
        ]),
        const SizedBox(height: Insets.i10),
        if (index == homeScreenPvr.bookRmtCnfgList.length - 1)
          Container()
        else
          SvgPicture.asset(eSvgAssets.lineRuler),
        if (index == homeScreenPvr.bookRmtCnfgList.length - 1)
          Container()
        else
          const SizedBox(height: Insets.i10)
      ]);
    });
  }

  Widget buildToggleButton(
      BuildContext context, HomeScreenProvider homeScreenPvr) {
    bool isActive = appArray.localBookList.any((element) {
      return element['book_id'] == data['book_id'];
    });

    return SizedBox(
        height: Sizes.s22,
        width: Sizes.s41,
        child: FlutterSwitch(
            width: Sizes.s41,
            height: Sizes.s23,
            padding: Sizes.s3,
            toggleSize: Sizes.s17,
            value: isActive,
            activeColor: appColor(context).appTheme.primary,
            inactiveColor: appColor(context).appTheme.lightText,
            borderRadius: AppRadius.r40,
            onToggle: (value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (value) {
                // Add book to the list
                var arg = {
                  "book_id": data["book_id"],
                  "image_src": data['image_src'],
                  "chapters": data['chapters'],
                  "book_name": data['book_name'],
                  "image_name": data['image_name'],
                  "link": data['link'],
                  "selected_chapters": null,
                  "reading_time": null
                };
                appArray.localBookList.add(arg);
                String jsonString = jsonEncode(appArray.localBookList);
                await prefs.setString('bookList', jsonString);
              } else {
                // Remove book from the list
                appArray.localBookList.removeWhere(
                    (element) => element['book_id'] == data['book_id']);
                String jsonString = jsonEncode(appArray.localBookList);
                await prefs.setString('bookList', jsonString);
              }
              homeScreenPvr.notifyListeners();
            }));
  }
}
