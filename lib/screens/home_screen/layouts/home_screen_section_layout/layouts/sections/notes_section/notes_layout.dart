import 'dart:developer';

import 'package:bhakti_app/config.dart';

class NotesLayout extends StatelessWidget {
  const NotesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context1, homeScreenPvr, child) {
      String currentText = homeScreenPvr.notesCtrl.text;

      int fetchedDataLength = homeScreenPvr.notes.length;
      int currentTextLength = homeScreenPvr.notesCtrl.text.length;
      homeScreenPvr.shouldShowTick =
          currentText.isNotEmpty && fetchedDataLength != currentTextLength;
      log("shouldShowTick $fetchedDataLength");
      log("shouldShowTick $currentTextLength");
      log("shouldShowTick ${homeScreenPvr.shouldShowTick}");
      return Container(
          height: Sizes.s119,
          decoration: BoxDecoration(
              color: appColor(context).appTheme.containerClr1,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: appColor(context).appTheme.primary.withOpacity(0.2),
                  width: Sizes.s1)),
          child: Stack(children: [
            TextField(
                onChanged: (value) {
                  homeScreenPvr.shouldShowTick = true;
                },
                controller: homeScreenPvr.notesCtrl,
                style: appCss.dmDenseRegular14
                    .textColor(appColor(context).appTheme.lightText),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(Sizes.s15),
                    hintText: language(context, appFonts.enterNotes),
                    hintStyle: appCss.dmDenseRegular14
                        .textColor(appColor(context).appTheme.primary),
                    border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                maxLines: 4),
            if (homeScreenPvr.shouldShowTick)
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                          margin: const EdgeInsets.only(
                              bottom: Sizes.s6, right: Sizes.s6),
                          alignment: Alignment.center,
                          height: Sizes.s32,
                          width: Sizes.s35,
                          decoration: BoxDecoration(
                              color: appColor(context).appTheme.primary,
                              borderRadius: BorderRadius.circular(8)),
                          child: SvgPicture.asset(eSvgAssets.tick))
                      .inkWell(onTap: () {
                    homeScreenPvr.notifyListeners();
                    homeScreenPvr.shouldShowTick = false;

                    homeScreenPvr.setLoading(true);
                    FocusManager.instance.primaryFocus?.unfocus();
                    homeScreenPvr.updateData(context);
                    homeScreenPvr.getData(context, isTap: true);
                  }))
          ]));
    });
  }
}
