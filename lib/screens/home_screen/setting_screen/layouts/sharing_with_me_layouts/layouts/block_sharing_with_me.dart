import 'dart:developer';
import 'package:bhakti_app/config.dart';

class BlockSharingWithMeDialog extends StatelessWidget {
  final Map<String, dynamic>? data;
  final int? dataInt;

  const BlockSharingWithMeDialog({super.key, this.dataInt, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context1, settingPvr, child) {

      return Builder(builder: (context2) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
                height: Sizes.s175,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VSpace(Insets.i10),
                      Center(
                          child: Text(language(context,appFonts.stopSharing),
                              style: appCss.philosopherBold18.textColor(
                                  appColor(context).appTheme.primary))),
                      const VSpace(Insets.i10),
                      Center(
                          child: Text(language(context,appFonts.areYouSureToStop),
                              style: appCss.dmDenseRegular14.textColor(
                                  appColor(context).appTheme.rulesClr))),
                      Center(
                          child: Text(language(context,appFonts.sadhana),
                              style: appCss.dmDenseRegular14.textColor(
                                  appColor(context).appTheme.rulesClr))),
                      const VSpace(Insets.i25),
                      CommonSelectionButton(
                          textTwo: language(context,appFonts.delete),
                          onTapOne: () => Navigator.pop(context),
                          onTapTwo: () {
                            if (data != null && data!['uid'] != null) {
                              settingPvr.blockSharingWithMe(
                                  data!['uid'], context);
                              log("stop");
                              Navigator.pop(context);
                            } else {
                              log("start");
                            }
                          })
                    ])));
      });
    });
  }
}
