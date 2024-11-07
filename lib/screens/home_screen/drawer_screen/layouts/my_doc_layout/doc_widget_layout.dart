import '../../../../../config.dart';

class DocWidgetLayout {
  Widget docDeleteDialog(homeScreenPvr, context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
            height: Sizes.s175,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(language(
                      context, appFonts.areYouSureYouWantToDeleteTheDocument)),
                  const SizedBox(height: Sizes.s20),
                  const VSpace(Insets.i25),
                  CommonSelectionButton(
                      textTwo: language(context, appFonts.delete),
                      onTapOne: () => Navigator.pop(context),
                      onTapTwo: () async =>
                          homeScreenPvr.deleteDocOnTap(context))
                ])));
  }
}
